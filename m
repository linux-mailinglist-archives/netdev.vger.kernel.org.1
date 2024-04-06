Return-Path: <netdev+bounces-85376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B189A7E7
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 02:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED12B2295B
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4D36B;
	Sat,  6 Apr 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b="jRegVpOo";
	dkim=permerror (0-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b="CqttKwZg"
X-Original-To: netdev@vger.kernel.org
Received: from gagc1.tesaguri.club (gagc1.tesaguri.club [172.93.166.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866C33CA
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.93.166.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362945; cv=none; b=IPZ8frnin9porGusAUutgBi8WecfuH7+K/EW9sP/WXBQlJyewrQpPchiokWAxqhEjBDTTbYWhGi9hzGCbupKYvbbLgOP0JEZAa0JpMkVoxGVi73bR/0UNdtyQhcNmD9zHWdpxzYuLwUMwfGwzfGaFpkB5dlpo9Y/F6dVTEVynDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362945; c=relaxed/simple;
	bh=SfjKoGPQWd50mkR6vrn3SUwCA2WfaGvIyearBw0Q16g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JyCqv1BPsI0D877aruYP9aOSkKROuY4zQ7uLhjXTsS7hcv3y1VX2YHZSg8hVdeCqZXaqMYf7KijMEhMSMf4xl0Pvqm/plCKIvMZ/zLvPEA1A5Vd/KA8yjqRsiz+Qh49pIoh4MdR6slClEZqHObGfcb8lSBS1FGICTBXwOpv/mtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesaguri.club; spf=pass smtp.mailfrom=tesaguri.club; dkim=pass (2048-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b=jRegVpOo; dkim=permerror (0-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b=CqttKwZg; arc=none smtp.client-ip=172.93.166.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesaguri.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesaguri.club
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesaguri.club;
	s=rsa; t=1712362936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfjKoGPQWd50mkR6vrn3SUwCA2WfaGvIyearBw0Q16g=;
	b=jRegVpOoF1QrPLhA/EiDhifAca0vdHVC+aK1KHN7uZtmfbI95XR0ErtaTj0/01fe9X5OJK
	xs7HptnDTAX0/cB+XXsebvv03VbBaoPAdQgiCHj2ZTWrTIsem0OtqL6AHxXAQpOEMSR6AY
	wrVomJ4mTRoQnEnPzWwQ81E+J3uCEX1lhWZx5fmH7jxcGlWVcovp3N0d5H8VgcE2SHljs+
	YTZtZJO+7mhKW308X/0rJk2JiVStvWtvpttcFhR+oVFOw6uGdoBY0c4N6QzQkS0dKEP55d
	2TH8qSX8RGIWjXI/4ZnXhZe7d2xFBCDzf8207vZmVHRpRp/rMb100Ikf2IPTTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tesaguri.club;
	s=ed25519; t=1712362936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfjKoGPQWd50mkR6vrn3SUwCA2WfaGvIyearBw0Q16g=;
	b=CqttKwZgvLlK9VnIC8+jqMH8g0toiqvbhEq39iBJya7D0swJxLBPbt83e1h6f/ZVmCW7FV
	6CNPG0NRgUc4nBDw==
Date: Fri, 05 Apr 2024 20:22:16 -0400
From: shironeko@tesaguri.club
To: Eric Dumazet <edumazet@google.com>
Cc: Jose Alonso <joalonsof@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Soheil Hassas Yeganeh
 <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
In-Reply-To: <f6a198ec2d3c4bb5dc16ebd6c073588b@tesaguri.club>
References: <20230717152917.751987-1-edumazet@google.com>
 <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
 <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
 <CANn89iKm5X8V7fMD=oLwBBdX2=JuBv3VNQ5_7-G7yFaENYJrjg@mail.gmail.com>
 <f6a198ec2d3c4bb5dc16ebd6c073588b@tesaguri.club>
Message-ID: <e463df8c95bfce3807459e271e161221@tesaguri.club>
X-Sender: shironeko@tesaguri.club
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The patch seems to be working, no more dmesg errors or network cut-outs. Thank you!

There is however this line printed yesterday afternoon, so seem there's still some weirdness.
> TCP: eth0: Driver has suspect GRO implementation, TCP performance may be compromised.

