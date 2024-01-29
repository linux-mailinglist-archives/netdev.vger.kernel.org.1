Return-Path: <netdev+bounces-66703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD284056C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248EB1C2242B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFB627F8;
	Mon, 29 Jan 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALOKcqtL"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3F664AC;
	Mon, 29 Jan 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532397; cv=none; b=kQ3gga95xR8GxZVXVw4OIDneLRQ34eZkN6J8I/tteCls3vEIht/9lkJPjew7uaSH5P8F/hHXqNtWfsm5CiT+HKzvW1uAGgskFZBQtBzMz19MPsG2hbd7fxg/H04v2MDeRAvqIl/IxzpXsl231XkkDyV8kvzvbwnXdTNro3NBt28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532397; c=relaxed/simple;
	bh=7Yilvkupz0oDd+E6cIBG/h5GEk3cG76fW2x3TJjFpt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7xteMLk46UP634YUlJIM5a8fDGVG0WMhRYc3SJbByEC0Ap+KliYATmcpzczIPskwY+2XGhMeniI9856O8rC/qfb/vyVPgz3EMBOmyqokRPhSC8UkOI0CEvS4x4BcPFhc8FZpyCcZaE/mpENDB9edqAJMBbaauW9qanswgpxPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALOKcqtL; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EF2415C012E;
	Mon, 29 Jan 2024 07:46:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 07:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706532394; x=1706618794; bh=vmjn+hTFBMhpDC8rNFwn98KmfDv+
	9w+C8Duaw53B+zQ=; b=ALOKcqtLvJe8WSFRrGD71dHyv5UwX8Xb6v7Eb20WOT7R
	2MiHXbyEFAuJSxVJhL1t1sIidv+JBy4e63ZlZaRKm3+bHh8OovI29cuInL7HXFR9
	kNN9e5kXQJtHE55XAuz1nDm/r4BJ0QKpKaj6v6Is2dsdiWL35JPaIOTBYEmSY1LD
	7MlirwuTindv1ONjGyKhgd3qFPFwS4uBM0BYvvmt2BEUEGOruhM1ZfM/1XREO2Y7
	sRpWMIsoxkGLUSf6OU619lAl/HslSSWcTvTl+5sgBRFZjrrQ5cfII3Wg4y3hagJR
	0sHwO/h0GGnAFU0neiZ6EEsww5JInPSFRTMuZisHQA==
X-ME-Sender: <xms:Kp63ZcirjGUj2XvHYI8gFIk77uPa3HXBgpwiMPPUbujOnurAFcNmDA>
    <xme:Kp63ZVDwkLPZ4tZtKuJrT9xs5Zs0TRODso_TlADXXk3fpI3WgPwb9HjG5wm6qSxfa
    3QaOuRlfnBIgnE>
X-ME-Received: <xmr:Kp63ZUGKvo3i4eNN3Iv-nzSOMyQyXZhxoiYVIFvc95O7ZkCfSdhi4KPdrshB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegte
    eiieeguefgudffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:Kp63ZdSvJqFZvfqZmUBzFBSfos2z1fa3eTAhmq3TGyoBXVhRZTK-ow>
    <xmx:Kp63ZZwZJYu-Qm9hB7aokllBH4hF1MZgdImAy722VfCmCeMObWzzXQ>
    <xmx:Kp63Zb6rhPj67_qIOqDGKsMZ8Bbyd-185XpvSEbHCuL3l_a0RSPNHg>
    <xmx:Kp63ZXZOICBejGpwK49kbfw2kWV1FPGxhmukQ_qcKoV22GKtclCvsA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 07:46:34 -0500 (EST)
Date: Mon, 29 Jan 2024 14:46:32 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <ZbeeKFke4bQ_NCFd@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
 <ZbedgjUqh8cGGcs3@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbedgjUqh8cGGcs3@shredder>

On Mon, Jan 29, 2024 at 02:43:49PM +0200, Ido Schimmel wrote:
> On Mon, Jan 22, 2024 at 09:16:12AM -0800, Jakub Kicinski wrote:
> > If you authored any net or drivers/net selftests, please look around
> > and see if they are passing. If not - send patches or LMK what I need
> > to do to make them pass on the runner.. Make sure to scroll down to 
> > the "Not reporting to patchwork" section.

Forgot to mention: Thanks a lot for setting this up!

> 
> selftests-net/test-bridge-neigh-suppress-sh should be fixed by:
> 
> dnf install ndisc6
> 
> selftests-net/test-bridge-backup-port-sh should be fixed by:
> 
> https://lore.kernel.org/netdev/20240129123703.1857843-1-idosch@nvidia.com/
> 
> selftests-net/drop-monitor-tests-sh should be fixed by:
> 
> dnf install dropwatch

