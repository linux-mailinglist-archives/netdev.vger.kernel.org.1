Return-Path: <netdev+bounces-41469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF97CB0E1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E63AB20E1A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470E30FA7;
	Mon, 16 Oct 2023 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt3IksFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0831168DE;
	Mon, 16 Oct 2023 17:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0DFC433C7;
	Mon, 16 Oct 2023 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697475710;
	bh=jrSWt+qKvM3F/hpjsvam+0cAPmswN21zpfkWuyRqu78=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Jt3IksFvaDHMbpKErxsfMA09XrC2usal72zOnisU3M4xvVRjObjhiu4/Cn8+FXye1
	 M3EFWfb1p3k/2Bf5H38SmJoJwO1tDpl0HElPWT7HuhExehnK0wUt3ugetUVYzdvyh5
	 smxHUf6q/A5vyiwcVCLRAOpv9Sn4XbZvJ2EzrQ5BCpNuwqhGElNv9eCa3d+QB08qyQ
	 JGd3oKSh1zBPn7yb9RP7gVVE0Mk2av+CNopCp5nTUs+2cTTmjKByS9QZOPk8wI126M
	 +zekt2PSjUpypr/3c/9fKtLZHqP6oYy3ebEVCtQPQbt/j53SFND+mnCpxEQjvK1xz2
	 NF1qgeUsV67/Q==
Date: Mon, 16 Oct 2023 10:01:20 -0700
From: Kees Cook <kees@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>
CC: Justin Stitt <justinstitt@google.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-hams@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
User-Agent: K-9 Mail for Android
In-Reply-To: <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain>
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com> <20231015150619.GC1386676@kernel.org> <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain>
Message-ID: <FA371CE1-F449-44D4-801A-11C842E84867@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 15, 2023 10:47:53 PM PDT, Dan Carpenter <dan=2Ecarpenter@linaro=
=2Eorg> wrote:
>On Sun, Oct 15, 2023 at 05:06:19PM +0200, Simon Horman wrote:
>> On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
>> > strncpy() is deprecated for use on NUL-terminated destination strings
>> > [1] and as such we should prefer more robust and less ambiguous strin=
g
>> > interfaces=2E
>> >=20
>> > We expect both hi=2Edata=2Emodename and hi=2Edata=2Edrivername to be
>> > NUL-terminated but not necessarily NUL-padded which is evident by its
>> > usage with sprintf:
>> > |       sprintf(hi=2Edata=2Emodename, "%sclk,%smodem,fclk=3D%d,bps=3D=
%d%s",
>> > |               bc->cfg=2Eintclk ? "int" : "ext",
>> > |               bc->cfg=2Eextmodem ? "ext" : "int", bc->cfg=2Efclk, b=
c->cfg=2Ebps,
>> > |               bc->cfg=2Eloopback ? ",loopback" : "");
>> >=20
>> > Note that this data is copied out to userspace with:
>> > |       if (copy_to_user(data, &hi, sizeof(hi)))
>> > =2E=2E=2E however, the data was also copied FROM the user here:
>> > |       if (copy_from_user(&hi, data, sizeof(hi)))
>>=20
>> Thanks Justin,
>>=20
>> I see that too=2E
>>=20
>> Perhaps I am off the mark here, and perhaps it's out of scope for this
>> patch, but I do think it would be nicer if the kernel only sent
>> intended data to user-space, even if any unintended payload came
>> from user-space=2E
>>=20
>
>It's kind of normal to pass user space data back to itself=2E  We
>generally only worry about info leaks=2E

True but since this used to zero the rest of the buffet, let's just keep t=
hat behavior and use strscpy_pad()=2E

-Kees

--=20
Kees Cook

