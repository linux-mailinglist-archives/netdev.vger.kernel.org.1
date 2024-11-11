Return-Path: <netdev+bounces-143845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F59C4710
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE2528BFE5
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89519DF98;
	Mon, 11 Nov 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="FGFw1Und"
X-Original-To: netdev@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48024145346
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357737; cv=none; b=J8C+5zB06IYM/bVjo1qLrkydGs6pXSBN3mTNpzIN7fV+NUkZO00h62OYqdnU49N9QX0wReLF1ieJeS59HuYN8rmik2WVIEQx+6KztnPsvL1/5kD/x15qnYvE6OTD+D9EIKxR3D7rW0rOub3DfGqlBVLs9US0gZ/t/jhAWZw8e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357737; c=relaxed/simple;
	bh=6/Pwl6baKxx8bpBpaUXLmfLTAz1VSpRNSyoyp4z5Ww4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=L3jCjZMnhaiCIoCqvK/II38Hv6+vDE/hp8wMEx2wHC/CRJyPSf+/erm1X6PS5mUZcLgNt+Av2+k7paQalc7VBoyCTM+PHz6YJrp0Nq6UGmpX9ApoozXnxGC1LJP4WK6Trii5/mPMqHz/usHPpMqC0tWhhvoKtPXFr9zqhNAGr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=FGFw1Und; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731357724; bh=6/Pwl6baKxx8bpBpaUXLmfLTAz1VSpRNSyoyp4z5Ww4=;
	h=Date:To:From:Subject:From;
	b=FGFw1Und9NSjVJSk6F4Rwfi+mBjBSpHZkH026zbs/wMBTUqeaklXEEMw+7ZpA5shM
	 A1n6H+dasTe3OPHH+uQm+QsVy5m+GFz4GYb/4yyypAkcEm5ITYowny5VKNSrRiwr8S
	 QqqEKOL+fFa5zJnC2RDibNilHyu86mFWH7JCCgJQ3ZPObLwhLgh6ukaDWRxBvM80R8
	 HBqPxRuN1rytF2hFlI3jbqcIKq9lnW0R7GCyGJDUgtpaOKiC5IxtFG+shaUBX0Cezl
	 k09JYUcsaAKVXD3+95fcFSa7tq4nOsbdTwrzPxp+RJIYSv1aVSkvhIGk0BpFG8SdOA
	 oJAUbNibwxxw73VG1vr+M3ja7tdhm9N0jXW9CtEpyAl4EkoXuktdNqa5LY/hZX/IdX
	 nlszZj2zc2lh1eYvAdIAIrnA4vU3HcOfy47r450C6/mdOFgO9GtUnjigEc21SdRz7f
	 HAk+ga/xSTCpUI7wgDuURc4QvdzpPGwVprX5apNvtSaASEj4zXCpa7VoRDGdfXguFC
	 fsJbKCQNmOmA6FfLwsHstixwtGpTfcyKmCBpfeZ09SoyRUx2/A9eB4ztwaU9HJ4AKV
	 dA0FGQCkXfyM3GnX9WqWMjG2FhOGX5yTECK6lbtowDaDnuAO2njJlIhwSQh2DIFtR4
	 hny3qips8w0shCMPpwNhk+lo=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 1A0B61683CF;
	Mon, 11 Nov 2024 21:42:04 +0100 (CET)
Message-ID: <f9eb1025-9a3d-42b3-a3e4-990a0fadbeaf@ijzerbout.nl>
Date: Mon, 11 Nov 2024 21:42:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
From: Kees Bakker <kees@ijzerbout.nl>
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steffen,

Sorry for the direct email. Did you perhaps forgot a "goto out_cancel" here?

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
[...]
@@ -2576,6 +2603,8 @@ static int build_aevent(struct sk_buff *skb, 
struct xfrm_state *x, const struct
      err = xfrm_if_id_put(skb, x->if_id);
      if (err)
          goto out_cancel;
+    if (x->pcpu_num != UINT_MAX)
+        err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);

      if (x->dir) {
          err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);

-- 
Kees Bakker

