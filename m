Return-Path: <netdev+bounces-217776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92775B39CD9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEA204493
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3A2FE56E;
	Thu, 28 Aug 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MdvUZhgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pcv7lhaP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BA30F818
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383318; cv=none; b=ZfwN2UyhN9u7T6vFBRre/BUYskGGtVbxgAfRPfiKZXScqY81L1IMjr9pvWZDGG41WTS5gK2OfuL+oJJV3pJr2jxA9eNGz0CgBJSUhJ3PY3tvpkTuxa5s9mvpCMl9+Y2rMwvz0vWmJZyzqyk1nH7SwDRF5fw4R495kosgo8VNhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383318; c=relaxed/simple;
	bh=sPJgXka8mDRlEQO4nkTEm86oQu2D6kz2XhsgKNay7o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzbpFW3cYXU9YRnH4pEqr32dY1rrC/C8kJuSdZGafKoQOjouKeriQ7SAxHSTMUTDDaXJe1ENTrNA3OODaeSDBM5SumKR409VQcdE6k2UpvMA28QUkKN4UGjXLt1vwQugvHm8FZ9CwLVSkSZ/+h/BRIuep4xhpvyGRFEPYKHPGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MdvUZhgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pcv7lhaP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 414EF7A01B3;
	Thu, 28 Aug 2025 08:15:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 28 Aug 2025 08:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756383315; x=
	1756469715; bh=BfMtW0vrr0L4+Y3jUnjihQ6A0zOcpfGLYjhPgPZ9vww=; b=M
	dvUZhgB1zQC52XLm40I+IqGDkz7uSbERUoXRCRVBN1VM18OCuVSjWabT21WEK/Yh
	bCU4qYryvhc3WgzyRtCD6vB3DRXz3rvr7hMbQi2ONdpoPOLmS1+XRNtKc1xAocVv
	AlVb/EgUEE/Qqdm+DsuxzGZBNzyQxam+qnA9OEoFa+ifiM9zVu+LMQNAYQONpQyv
	/ZGkoCV7y6RKZWA41juz3D5+CyJCYrBcdv3GHBGTQ/3S/Gw6vq9LXLC1DLnQiDm5
	3lS65ICnGuJOhQ+X84q0g45dNNQ73mKSseJkPZxPK+HFJEnfrwBv23XnvGpezscn
	EkSJId8422wu67eRiwMgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756383315; x=1756469715; bh=BfMtW0vrr0L4+Y3jUnjihQ6A0zOcpfGLYjh
	PgPZ9vww=; b=Pcv7lhaPsUNIiR4CQNtmKKCq4cy/0WChuplRD8kOC6+eb5+u9VF
	NSkb2pxA70A+v+zmPpJhNgA585d8YkuwuxIsdWberR1m1t7GjvfkSdLJgRm1+rK2
	Wzr1YB7wQKHEnKCRXkKeB51XgKtaee2jD5DQNthEfZGkLsb9dNbwaIVRHFt5d7+s
	1VgqGL8k/L1x7XWfoZH7F58bl7m7beiuUIddP/vNthd+kq6pFryI7vhC3SoyHYPm
	ef4KQkhHmR1S2sq+fn3sIlx3r2QH7Hye7pud17qnwGJsqzDjZzJEHQLBYYRhXXNp
	boTBT9hXly1r3rRoxxUhjDbtilt9jAX8b0Q==
X-ME-Sender: <xms:UkiwaIPdYbZz-_h6m5uAKIsdFv1zmi6TCqMxmTo7gFXtqWOGi4sWLw>
    <xme:UkiwaPL4u5cg0m66RvO2885SLnIwiZ7NAVmtzWLPF7i7BN8yN_nqePh3lRCm-WAGG
    2CgUHcPHCpQ4ikehuk>
X-ME-Received: <xmr:UkiwaBG0pP9N-rP96PCE1ZRdL8ADa_6ezU3j5JdVL54AgsbClgmvmKklJ16o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UkiwaPRuWnrwbQr9zJj6HwqARpNx7pZDUqFiGXskND4tV_cePtweEA>
    <xmx:UkiwaFFhuNa-WwK4sKjJp212ueHK_lMVZ1X3OTUdROVD22dQy1Dl8A>
    <xmx:UkiwaD_oMOQXqCCniit7TbY6U6nJ5pnzSFFIfOomkub3L1R0G233bA>
    <xmx:UkiwaHJ0YYda-PYA5-Kt8f_oQlpxgjGQmfjvPTNd02l8LDjD9uAhkA>
    <xmx:U0iwaHQD-jqW1mbyhnBWxp9JlQYT2SyT0dKrZhvW-ybMeKMbW34x2fEx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 08:15:14 -0400 (EDT)
Date: Thu, 28 Aug 2025 14:15:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/13] macsec: add NLA_POLICY_MAX for
 MACSEC_OFFLOAD_ATTR_TYPE and IFLA_MACSEC_OFFLOAD
Message-ID: <aLBIUPQP_R972YXs@krikkit>
References: <cover.1756202772.git.sd@queasysnail.net>
 <37e1f1716f1d1d46d3d06c52317564b393fe60e6.1756202772.git.sd@queasysnail.net>
 <20250827185149.48b45add@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827185149.48b45add@kernel.org>

2025-08-27, 18:51:49 -0700, Jakub Kicinski wrote:
> On Tue, 26 Aug 2025 15:16:26 +0200 Sabrina Dubroca wrote:
> > This is equivalent to the existing checks allowing either
> > MACSEC_OFFLOAD_OFF or calling macsec_check_offload.
> 
> AFAICT "equivalent" is a bit misleading as we didn't have validation.
> But seems low risk.

We didn't have validation, but macsec_check_offload would return false
if offload was not one of {MACSEC_OFFLOAD_PHY,MACSEC_OFFLOAD_MAC}.
So I don't think this is adding any constraints compared to what we
already did.

-- 
Sabrina

