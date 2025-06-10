Return-Path: <netdev+bounces-196006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858DAAD3160
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF7F3A3D8E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A72F28A727;
	Tue, 10 Jun 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZmNqYGwb"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490228B7F1
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546690; cv=none; b=LiT+L9VKnhno4r91/1oCmX1iGNXVKiUzwiASTHSMvVjtUxuoaWBVt0CkPxPAOFr/D+DGdzzEjnToHOtMaAvWEuPqWtMY7Hpi7vvF+cE7KKuEO5v9UaokPyen/3NIBiBf7U1sA4cDKQ2YBhfPZ1COlVl8CtAZiCPFfQoI4wQqGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546690; c=relaxed/simple;
	bh=9anzCkLa9MXw6aZtNXBr2K9y68pZ+bkSnCoMWyUH4V0=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=X5YliFkJiERrrIXKYEGfBs4bZ0KSdoUSqZyCQfUA1EiqIXChKc0wqObN1C1yqR+6uUMBeWuIRyp6RcIlBjUWw4jsNKYoDj2dEoawo8ANIyPyvKtg7jfcy+zf+gV4qeQ+5HHbLVo7+K2DpSne2OG7YCmxmsfPfRxmEm/Qfa4yttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZmNqYGwb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250610091125euoutp020efaf77fd8f2bb7b495275f8305aa90c~Ho3DfIrjQ3156531565euoutp02I
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:11:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250610091125euoutp020efaf77fd8f2bb7b495275f8305aa90c~Ho3DfIrjQ3156531565euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749546685;
	bh=9anzCkLa9MXw6aZtNXBr2K9y68pZ+bkSnCoMWyUH4V0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=ZmNqYGwbs+K96//SzvY2L0QWp+m/QYyzAf4xAek4HsWXYi0hgGbwf064I/jK0jUAE
	 +YqCx5QDtE5KgFA8cAHo/EcMAhxmmiScp1W1om0EoWmIXSBYUwa/bYuU7Xgtp0okr0
	 l+B4k8gRHPDaALHFlos4mHSYn8Q0nAp/B79cxRNo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: Re: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment
 free in __xsk_generic_xmit()
Reply-To: e.kubanski@partner.samsung.com
Sender: Eryk Kubanski <e.kubanski@partner.samsung.com>
From: Eryk Kubanski <e.kubanski@partner.samsung.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250610091125eucms1p3b7b0b19a533caffddce07c75596f3714@eucms1p3>
Date: Tue, 10 Jun 2025 11:11:25 +0200
X-CMS-MailID: 20250610091125eucms1p3b7b0b19a533caffddce07c75596f3714
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-EPHeader: Mail
X-ConfirmMail: N,general
X-CMS-RootMailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
References: <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p3>

> I've come with something as below. Idea is to embed addr at the end of
> linear part of skb/at the end of page frag.

Are you sure that this is safe for other components?

So instead of storing entire array at the skb_shared_info (skb->end),
we store It 8-bytes per PAGE fragment and 8-byte at skb->end.
Technically noone should edit skb past-the-end, it
looks good to me.

In=C2=A0xsk_cq_submit_locked()=20you=20use=20only=20xskq_prod_write_addr.=
=0D=0AI=20think=20that=20this=20may=20cause=20synchronization=20issues=20on=
=20reader=20side.=0D=0AYou=20don't=20perform=20ATOMIC_RELEASE,=20so=20this=
=20producer=20incrementation=0D=0Ais=20atomic=20(u32)=20but=20it=20doesn't=
=20synchronize=20address=20write.=0D=0A=0D=0AI=20think=20that=20you=20shoul=
d=20accumulate=20local=20producer=20and=0D=0Astore=20it=20with=20ATOMIC_REL=
EASE=20after=20writing=20descriptors.=0D=0AIn=20current=20situation=20someo=
ne=20may=20see=20producer=20incrementation,=0D=0Abut=20address=20stored=20i=
n=20this=20bank=20doesn't=20need=20to=20be=20synchronized=20yet.

