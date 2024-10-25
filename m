Return-Path: <netdev+bounces-138931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A199AF754
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A8EB21128
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C613212A;
	Fri, 25 Oct 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WdZtxBU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224A487A5
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822744; cv=none; b=uD3OnbXONQ1n85IeVr1FByBs+isP9PzPK0vLftVVJdRpzuSV2SloicWkSowNZDItuXYeAP8umpgniS6EsxWsH5zc858kp1JNqiCZ2qFZbRrctQaGq9+2Epk/XUZDF8zZLO/lspReTIAgZQxRtxWY+wD6gQ3ElP0svZSj80pdtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822744; c=relaxed/simple;
	bh=UMqHgfu8cmScl54z1K7zA0BrJsl5cBiexkBnEW+Kazo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nDulEhbn8hUAlmzTgbTCYTUEcBsqkCSqiHV6ApPX3gYxRjUNu5TlaJgNrY8On5J7oztPLbS+GCVqWP8LBzP938tyPNcJSfmruT5hU+rtZ6OXJensgNCDBIXqAOpz/KoMpSCfNVpt4R0Ct+VzSOVlopTU3PazwCu9sG7vCpW2mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WdZtxBU+; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a99ebb390a5so494591366b.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 19:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729822740; x=1730427540; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJe3jVd+/dp2p1yp6uLHWnUyxyih+vJcUqh0CQwQIKs=;
        b=WdZtxBU+uy+kBm69d4jJyvlnGmmtLy/IRCMJCgbEzbxUUEH84BmS5qkJ8SznLCX3Ay
         3QDp8BVxFl9k9rfXfQIXLm+mJgkA8waonik36Caoam2z4xyUYnpzqnSmx6yerpl6DQCJ
         EAYDFbxAgfV8X5eGakeOslYtYcCw7ucI92jKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729822740; x=1730427540;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJe3jVd+/dp2p1yp6uLHWnUyxyih+vJcUqh0CQwQIKs=;
        b=cRDvDsQMjIjdJZtAYC4bydPWXaFj8Q0CoECYh0LHQAftc6Etvi7bGG55ag+LQR+dm/
         8Y/98T1tNvGXrtyzkHCI5MRxkL5AsA2u48O+sGzHeqoeUrIZ9pblyHItlEq59X3/tBs5
         MpGSTYEvpt22zTRMxv4PUS8rrS44mG38eCxJXMJwQrfm1Q5J6+u4KR7qisKUPycuH8A9
         yldXGD09lCAcFBStO20SDju4xAKPzevfs7pNI68bnslIDWBR7OVs5Uxkld4BivBTmhEj
         PplWdehw2/bBsfUhN2M3pmFaDqgmUgDcz+5paOvUjpzpUweBXkBInn3pJfiqiDqbHZXj
         oWDg==
X-Gm-Message-State: AOJu0Yw07m+bm80UU7zjT+9WzE7eClsGUE7egHGF5XdTJvB5CxetakCs
	R0d5Vpw/XMgs0ESIbrDcCs4/0yq9pKPndATd+80KfDTf2LnIf4FdZNK2qfk1DXpC+BC9Cw3BnbL
	DdolZ/k2+J1cfeFzSE6qNaEYLX0W4xiMeoBTJV2rovCxXoOtuG617S99P
X-Google-Smtp-Source: AGHT+IHdYuXHSArjtLmLWoZX2uHuz4U9XuZJFSO4drgcrsqTArQ/65sblFCZx3ZJpBMyrvygRz8+THrCY+2GWGddc94=
X-Received: by 2002:a17:907:7f18:b0:a99:f722:2dde with SMTP id
 a640c23a62f3a-a9ad197b5admr409951766b.1.1729822739946; Thu, 24 Oct 2024
 19:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanjay Rao <srao@fastly.com>
Date: Thu, 24 Oct 2024 22:18:49 -0400
Message-ID: <CA+t96KDs8_4DcY-RuhX9L9r2LuES_8Cqihe3gCfnOhK8ffMkZg@mail.gmail.com>
Subject: Question about mpls_gso_segment() and skb->encapsulation behavior
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a question regarding the behavior of mpls_gso_segment().

In the code snippet below:


segs = skb_mac_gso_segment(skb, mpls_features);
if (IS_ERR_OR_NULL(segs)) {
    skb_gso_error_unwind(skb, mpls_protocol, mpls_hlen, mac_offset, mac_len);
    goto out;
}

The issue I'm encountering is that skb_gso_error_unwind() sets
skb->encapsulation = 1, but it does so without setting the inner
transport header (inner_transport_header). This leads to a kernel
crash within the driver code, specifically in
mlx5e_sq_calc_wqe_attr().

I'm wondering:

Is setting skb->encapsulation = 1 correct in all cases for MPLS packets?
If not, are there specific scenarios where this should not be set,
especially when the inner headers are not explicitly defined?

Any insights or suggestions on handling this situation would be
greatly appreciated.

Thanks,
Sanjay

-- 
Sanjay Rao | Principal Engineer | Ashburn, Virginia
Tel: 703-869-1461
fastly.com | @fastly | LinkedIn
Fastly Global HQ: 475 Brannan St. Ste 300, San Francisco, CA 94107, USA

