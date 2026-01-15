Return-Path: <netdev+bounces-250314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A0D28624
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF313009105
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A7320CAC;
	Thu, 15 Jan 2026 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="adCsGLOU"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A727318EE4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508577; cv=none; b=Avl3zSVppmC8pdAV1jyRld4bgm5vDuSAri2ATfzh3abL97GrfmD8r1PcBgfU0lvCyB28BLOlQOw7cIR9LQezfJJN8o9lC2RJbF9ApayyLmQLe1YPrpQm/U+bTF4+1jzPzyza7Z7T2oZynPjN+Z9VKneplrOYijqYtNaVFRGA/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508577; c=relaxed/simple;
	bh=UUZwAZQ5SIRk7HwpqbQbu52XUjCo5nXpivnmi1owl70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GyaKwoWDThKsG4cQHYRY8yUUS9JaWB/iiGWFy2F7j5oxtlJK+gmeANPdgkEO4ReFetjVTnpHEcROisuLHJLTJ3fvjPgQZG3Iy/oIK08yKS9Njgo8PuceruRktCuEAV3dZVc2487Y1AEQ+WbAcOF4EEAgCTIJOB+q3nftFRA0Y64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=adCsGLOU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=adCsGLOUHGcd88y+F8KiixXJFt97B23g6F4t6HzgGf0SpUdUlqiKJyf4P90reWsQ+sWTJ69624iHaxGDztFdexJ3kWohVBt1cxWDQ0t1tRPtMBv66HOZn2bTpWFNXMiC338UxvWDDElrnOemx4Ih9kx4D6A92zmH/eA/AUIueExlh7wpCE4M9nqwbn2AasDmIg7ROVy7w5Prj8xq6IMFeYtyQQE9LwqRap/uIV5GZV8YXmckpeCaC+uqESE9fENi95uOvyQhoWxnEuEoOQlKcomMkDFWMfCdV7NaYtnbv8i2MmJT8YZW74Be1VFdzonrq2RLy+ToHM0/GKkHXRM+UQ==; s=purelymail3; d=purelymail.com; v=1; bh=UUZwAZQ5SIRk7HwpqbQbu52XUjCo5nXpivnmi1owl70=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1724870722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 15 Jan 2026 20:22:45 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1vgTrg-000000091vt-1D1a;
	Thu, 15 Jan 2026 21:22:44 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Simon Horman <horms@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,  netdev@vger.kernel.org,
  linux-usb@vger.kernel.org,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: fix byte numbering in comments
In-Reply-To: <aWklu0EwMbINC6T0@horms.kernel.org> (Simon Horman's message of
	"Thu, 15 Jan 2026 17:36:59 +0000")
References: <20260113075327.85435-1-enelsonmoore@gmail.com>
	<aWklu0EwMbINC6T0@horms.kernel.org>
Date: Thu, 15 Jan 2026 21:22:44 +0100
Message-ID: <87jyxiy6az.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Simon" == Simon Horman <horms@kernel.org> writes:

 > On Mon, Jan 12, 2026 at 11:53:21PM -0800, Ethan Nelson-Moore wrote:
 >> The comments describing the RX/TX headers and status response use
 >> a combination of 0- and 1-based indexing, leading to confusion. Correct
 >> the numbering and make it consistent. Also fix a typo "pm" for "pn".
 >> 
 >> This issue also existed in dm9601 and was fixed in commit 61189c78bda8
 >> ("dm9601: trivial comment fixes").
 >> 
 >> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

 > Thanks,

 > I agree this is consistent with the cited commit.

 > Reviewed-by: Simon Horman <horms@kernel.org>

 > Context left below for the benefit of Peter who I've added to the CC list.

Heh, old stuff ;)

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

