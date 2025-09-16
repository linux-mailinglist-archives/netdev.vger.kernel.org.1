Return-Path: <netdev+bounces-223751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87BB5A45B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1783318825D8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6536313D79;
	Tue, 16 Sep 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cMWhQvQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123E1F4174
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059784; cv=none; b=cAPIcVyeGZJRedEtbgGCyUyPr1Oeb/08M5ZUzHpy7fsaPm6jwHkeg6SowrnTM8Iv/RZGk0KIs2T3PoYLSn5sMvPXVMSbb/dpDOXspzM9y/r/ODBqFMvyJkieT0vdnW0wziiVinU5p1acq3J8H6qR+P5q4gyDwVHM0QAc3HJplqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059784; c=relaxed/simple;
	bh=Rfni05o+aAG/k97d8EZO64WivmJxENN8JUt3TyX+mxE=;
	h=From:cc:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=OjtuI57Tews9mqhQSJLUDzZWOvbewSBYxr3XFGVUlV9EdH5fP5+TfijPILUPZH0F2oG87FJp4SEnK522L+2o4PLdKDzVhwmE/WnS+cxZ2bFhN9zlDVn1e37liXN4fIJNOcK8OWMEZCqk4zPmRfXl0nUHKTIbKsmZ9KDDSPKs1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cMWhQvQx; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EC3AB415E5;
	Tue, 16 Sep 2025 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758059780;
	bh=X6+B355vdyKxdVKYn77bhyMQT0MUDiOEkT7Lb7EMvpQ=;
	h=From:cc:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID;
	b=cMWhQvQx7Ho/pJ4qsdGSOSdWNRdFVzq9n9/lRqQyjLe6t1tCmMGmOhRC/KM+XhpXQ
	 ld9VFdLtNl/3nztcFy4DUNhPuCO7qzqHEBbxUV5DE15iLQf7cV0iifz8Fa3rWUgYzg
	 +A+34x31TmPsGxRWLSa6AZvHQz7wyN3o2w+j0X3kwzda32seZDotAsc98asKRwPLf9
	 ihTE4SvxdiZctQRONoZ13P965ooCL8h3wQ9KpdM+Pr6EJgblkXeTbLMk0/Lhuh1klD
	 9/Of8pkWEfMnTFprHXm0k3zXsdq2VV5OZsiMAXQy+gqEPBo3Wr4DM7u8NgmRmAfOnp
	 +lJRU3sJxQc4Q==
Received: by famine.localdomain (Postfix, from userid 1000)
	id BB36A9FC97; Tue, 16 Sep 2025 14:56:18 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B82999FC62;
	Tue, 16 Sep 2025 14:56:18 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
    Stephen Hemminger <stephen@networkplumber.org>,
    David Ahern <dsahern@gmail.com>
Subject: Re: 
In-reply-to: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
References: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
Comments: In-reply-to Jay Vosburgh <jay.vosburgh@canonical.com>
   message dated "Tue, 16 Sep 2025 14:23:59 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3431420.1758059778.1@famine>
Date: Tue, 16 Sep 2025 14:56:18 -0700
Message-ID: <3431421.1758059778@famine>

Jay Vosburgh <jay.vosburgh@canonical.com> wrote:

>
>
>Subject: [PATCH v2 0/4 iproute2-next] tc/police: Allow 64 bit burst size
>
>	In summary, this patchset changes the user space handling of the
>tc police burst parameter to permit burst sizes that exceed 4 GB when the
>specified rate is high enough that the kernel API for burst can accomodate
>such.

	Ignore this, will fix and repost.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

