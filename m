Return-Path: <netdev+bounces-237725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC63C4F9DA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 20:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87EE74E1999
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1F328B55;
	Tue, 11 Nov 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=zaharido@web.de header.b="WUiNw9ik"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53937328B43
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889746; cv=none; b=Q966MLfdf5e3tiKmTlwB7KjhjceaJWgmmVHi82U71XWM0Ehuwkueyt56mkEwUJoubyCzlJyVSTKP5bBa141MRbd9/b3mzurNHvig9ettg7l/VlTem4aqy+9nwhQTkp9BHsdPGHJ5TWGS4/dwBlTXH8X5opW8jg5Hz/9RKMT/jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889746; c=relaxed/simple;
	bh=OuHC9qAMvirA66L2Lom/FOaOsXgN4uQhEz9qF+uDXrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXymf/0lf+nGMewpVeULhTUjIpnq6SzuuGSQEJ6at8NqMtocNx2MNl9KTHZBTxbwgp8NwlE0AHWTYO52rXaehD7SeCDOr8worGoKIrBD/WGvM/CoYquCsO4p3hRJmrZZFMfaJug6wiWK0gk3uFzQycZTbJNqC/aBzPaZ4a9Khbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=zaharido@web.de header.b=WUiNw9ik; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762889735; x=1763494535; i=zaharido@web.de;
	bh=JUqCHbwk6UPwMJHh0uaak5h15UhJfiyKRz0NOTnL2do=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WUiNw9ikl7arSpPNEbpjEtQDsiDokCDFeTTaoDWHLpYfR58yn468eigLAlRjbg54
	 fdL/WpcGhCO8EWFVPAKXN/ZmUQKgno53Rd6Ws8+ZXMZ4V0mZ4sPRop67G3Kp/QUn5
	 OCwwND77fYe8ZMKpewet0BAfA6/YrRWE2olHma7x8yzzlzBaS/RkfRwbLNpl1yRPn
	 og9ejFpVEiUs4/xH3ZHjlfw8z7CTmKdvT5XWFSys4o5YBYuA5ebxmNhpUUubQsDMH
	 5GmVBNslNAUVqv2fC8jVQUfhwps0eUCm5YhIuEhCzlHbqsh++sgZn8GZcoa0m968m
	 xm30FF9fUR4p4bJIEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from hp-kozhuh ([79.100.14.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB86-1vUVHF1skw-00EYe0; Tue, 11
 Nov 2025 20:35:35 +0100
Date: Tue, 11 Nov 2025 21:34:28 +0200
From: Zahari Doychev <zaharido@web.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zahari Doychev <zahari.doychev@linux.com>, donald.hunter@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jacob.e.keller@intel.com, ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH v2 3/3] tools: ynl: ignore index 0 for indexed-arrays
Message-ID: <xk64zrtvsbasla4winq5apbfmfcbbkfeq2td2cpqzlzwurdthx@4o3jwsoztwzt>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
 <20251106151529.453026-4-zahari.doychev@linux.com>
 <20251110172016.3b58437d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110172016.3b58437d@kernel.org>
X-Provags-ID: V03:K1:n6RP21nJskT3g/A3Ibj3EyVONz8CAwEEBdTVviaOO79HJC49yre
 eFTrLZBAZffS3vy0CW1Y8V5z5EWyRyzBAN5X0cIzGlbjfgE7HV0Vfnunupb8Bzhzb6HoRsJ
 pB8fJkN+TEe5aiGDPf4pRymf+zRXV/ww7qyjFz8o5MbYx/ehNNLLU+Va8WwejMEiNlYTsLG
 Lxjr7pZSQCkFiS65zktBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YqKx+J6vrRE=;MOtMWdjh8F5NI/dBI4d0L5SsgIA
 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
 Zm+5F3oLmlDHjaJwGgBmAKb/UJKpWQK8dz8=
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 05:20:16PM -0800, Jakub Kicinski wrote:
> On Thu,  6 Nov 2025 16:15:29 +0100 Zahari Doychev wrote:
> > Linux tc actions expect the action order to start from index one.
> > To accommodate this, update the code generation so array indexing
> > begins at 1 for tc actions.
> >=20
> > This results in the following change:
> >=20
> >         array =3D ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
> >         for (i =3D 0; i < obj->_count.act; i++)
> > -               tc_act_attrs_put(nlh, i, &obj->act[i]);
> > +               tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
> >         ynl_attr_nest_end(nlh, array);
> >=20
> > This change does not impact other indexed array attributes at
> > the moment, as analyzed in [1].
>=20
> YNL does not aim to provide perfect interfaces with weird old families.
>

ok, maybe it is not that bad. I think I can workaround this by creating
a dummy action at index 0. Does it make sense to send an update of the
example with such change?=20

