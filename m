Return-Path: <netdev+bounces-31994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3823279203D
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 05:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952C6280F9B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 03:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E4564E;
	Tue,  5 Sep 2023 03:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474307E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 03:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69398C433C8;
	Tue,  5 Sep 2023 03:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693886132;
	bh=lLVUEbQlWPdqOrLlxxs6XsBseI0buyWLU4uLdO6rjow=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LDgmblXsH4okbJodYbvPlniFpqN89lQ3SXmqVe4Sou8FN9xKjLrSFjBDGFuoSKyI6
	 IOEaFE6uB3BhB3gwDFcvOp2WwwJYxrwWvCHIdNjvOx7zBWzGPyYtV4INNUW38Ows7m
	 gdTtPqDbO6Sb0BX1eZ3TXqki38Amve8jq4HFpqlV/UTCPVXncFTYPZ20TDabvSqpsF
	 48tGKtjsEjME/ZI+OxkaSBZIcyOqutkOyg6WqtgrOWemq2jkQ24TMbAG8oauYDMGig
	 E5TSxZlBEuHqoJvBReR0SjCNZCPvLClNBKhGR3+lZdFSteZT9RYnle6kdk+uV05pDL
	 2Ro3z09UFvMFw==
Date: Mon, 04 Sep 2023 20:55:29 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
CC: Kees Cook <keescook@chromium.org>, Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 David Laight <David.Laight@ACULAB.COM>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_net-next_v4_1/7=5D_overflow=3A_?= =?US-ASCII?Q?add_DEFINE=5FFLEX=28=29_for_on-stack_allocs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230904123107.116381-2-przemyslaw.kitszel@intel.com>
References: <20230904123107.116381-1-przemyslaw.kitszel@intel.com> <20230904123107.116381-2-przemyslaw.kitszel@intel.com>
Message-ID: <7AB970A3-883F-49A4-BBCD-23E2CD1E869C@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 4, 2023 5:31:01 AM PDT, Przemek Kitszel <przemyslaw=2Ekitszel@=
intel=2Ecom> wrote:
> [=2E=2E=2E]
>+/**
>+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family=2E
>+ * Enables caller macro to pass (different) initializer=2E
>+ *
>+ * @type: structure type name, including "struct" keyword=2E
>+ * @name: Name for a variable to define=2E
>+ * @member: Name of the array member=2E
>+ * @count: Number of elements in the array; must be compile-time const=
=2E
>+ * @initializer: initializer expression (could be empty for no init)=2E
>+ */
>+#define _DEFINE_FLEX(type, name, member, count, initializer)			\
>+	_Static_assert(__builtin_constant_p(count),				\
>+		       "onstack flex array members require compile-time const count");=
 \
>+	union {									\
>+		u8 bytes[struct_size_t(type, member, count)];			\
>+		type obj;							\
>+	} name##_u initializer;							\
>+	type *name =3D (type *)&name##_u

Yeah, I like this! This will make it easy to add __counted_by initializers=
 when we have the need in the future=2E



--=20
Kees Cook

