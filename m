Return-Path: <netdev+bounces-107154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB8891A22D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FC71F20FF7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B51327E5;
	Thu, 27 Jun 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfe8M1aS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A70132494
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479266; cv=none; b=XlS41cWTpsTbTFlmsX73KG+q/iLbgB58tLLcT6cNCG1SRNcIeS0YrODBAnXoi24UOKnlv5U1kYcmOhfaP+I0hsch3u857rk5jmGDCwAxYRjnKaDt/3fje/p0gT6WcIJuhhJxyiiYabb3T/JzdWAycvaPUv6ccbssywgJY4snaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479266; c=relaxed/simple;
	bh=x7cgPWoLbDpWq+yD3T8EogWBrR4vcZg41bBccJxfr5c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ci+m+uw8XY6xjveTW+2Awdc2clCyG1EBR3buUmkPSVQ85tdADTno5Gy332l6NBZ/gditEtrTuvpZzbf0zQflOHEicAnzpgPE9QAMNbjs4/rFxpmU0TvZWdquSDz9WhYZnvTW257wtD78RsWaD/m2tzxDyfoTDFcqr5z5t+k0OAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfe8M1aS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe61793e2so346734366b.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719479263; x=1720084063; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8b1GITht0qNgRagZsWstJIRfsn2Gp4D4YsmFwowHBrQ=;
        b=Kfe8M1aSkfpPhE6XVBYRgXRjdz6dOgNY9slavIQVhU5hSitL/p+EI/N4r38dm63kfQ
         KosHPkO47i53mPvFtWApTA/IeP8HnxHb1ncrWzlVkMY+Re8jrWMOMLvAmuo4PREdCKLp
         q/zo3QJyRKG7VeTCNxKieQvdt+/iNRb//9gRFqWlM79yfiUROB1OQYJdpIFwc8nLxb0n
         4t1eTccefS7JSl63PjiFfcBkvvZ3G5dC8txJ/LCriWg1Th0fO8/DxRqJNEQXTczMYetH
         cjiE3PAU+5ykAIAPjuFz7RJYNo/TO8B0UowHj2NzJy0uyruOT7kA4wsKUCZyK7DZ+yud
         GkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719479263; x=1720084063;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8b1GITht0qNgRagZsWstJIRfsn2Gp4D4YsmFwowHBrQ=;
        b=nFWac0vjLYtuFpKAv8JHelJjstv0QAEXomz2pkYWxJfWwTZ0mJuJ+8RZW4AnpRdt0d
         Hh9/ITF/VXL39P9bEDEuFuURutxDPiw5/rIQbsFtgZX66ITabegFN1p3rzDNvNwTmJqn
         GY5At9uC6R3nmxUC/DXi83Kv1NGFXuD/Q44Cext2dSijmxHX49Q34EVieC4Qr1WFAznf
         qRxvM8iDO9GcXCTPD74dd22C7OGVCrpJm3NqyRlYOifWOFViK8qGHzMqw1bAH9L9tOue
         Eufw8l0xaXEjo9ipYRxAwj34L+PF652QysTd/+gsvEoNu8hAeRiSGkvraPLpiuARwgcN
         Qxzw==
X-Gm-Message-State: AOJu0YwrVuIklqGKt42FCW5EXIU5V4xR4ErPAEV/3kxwhXUcNXySlKkA
	IVIJkyImWhwtJ/PYo0W8AJ9f/PRoI7pza7JXBQ/dBN8Q8J3FqKnV+xGdiyA3wcF843A9h4J10H+
	ZRZ4dr4FWgqaC9Q6cc6EMMtpt2IwUyh8=
X-Google-Smtp-Source: AGHT+IHifU+zoUYgY7EipirGpXAK9UtZWbVtAE7DLZscmkZYX45k9er29KgoMx34q4hjb62prCCebk052LT9L868eOc=
X-Received: by 2002:a50:c35b:0:b0:57a:3046:1cd8 with SMTP id
 4fb4d7f45d1cf-57d4bd5a0ddmr9688214a12.7.1719479263248; Thu, 27 Jun 2024
 02:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0KDRi9Cx0LDQu9C+0LI=?= <dairinin@gmail.com>
Date: Thu, 27 Jun 2024 12:07:32 +0300
Message-ID: <CADa=ObraXt4uEckHAGuhpvBa3ReUgcQkFMQweSBrGU9zpoOwnA@mail.gmail.com>
Subject: mlnx5_core xdp redirect errors
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a setup with 32 cpus and two mlnx5 nics, both running XDP
programs, one of which does redirect via devmap to another. This works
fine until the following happens:

1. Limit number of queues on both nics to 4 (< number of cpus)
2. Place incoming interrupt on a CPU >4 via irq_affinity
3. See redirect errors in trace:
          <idle>-0       [001] ..s1.  2010.232028: xdp_redirect:
prog_id=58 action=REDIRECT ifindex=5 to_ifindex=4 err=0 map_id=44
map_index=0
          <idle>-0       [001] ..s1.  2010.232033: xdp_devmap_xmit:
ndo_xdp_xmit from_ifindex=5 to_ifindex=4 action=REDIRECT sent=1
drops=0 err=0
          <idle>-0       [005] ..s1.  2010.232253: xdp_redirect:
prog_id=56 action=REDIRECT ifindex=4 to_ifindex=5 err=0 map_id=44
map_index=1
          <idle>-0       [005] ..s1.  2010.232257: xdp_devmap_xmit:
ndo_xdp_xmit from_ifindex=4 to_ifindex=5 action=REDIRECT sent=0
drops=1 err=-6

This narrows down to the code in mlx5_xdp_xmit that selects output
queue by smp cpu id, fails on cpu 5 and succeeds on cpu 1
The scenario is not very exotic to me, at least there is a need of not
running nic interrupts on all the cpus in the system, and not to be
bounded to first N of them.
Can this issue be solved in the driver, or I should start looking for
a workaround on the userland side?

Best regards

