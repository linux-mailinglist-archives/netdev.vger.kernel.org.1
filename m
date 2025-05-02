Return-Path: <netdev+bounces-187483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03DAA75F8
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F847BAC18
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825025A640;
	Fri,  2 May 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BhD3f6Fv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA1257AD8
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199536; cv=none; b=HWyKSd2VEKEsJkvntasN6njmGaJJwodV2XqcdIFh709MkJGYl0TmgtL8Uf0Fmhac7vXj20Gx9SHeY+u+BNGuYtbn7TTJZ/vCBOXwpkWF0eJZNkuUAOt2LLeIj7oc9TD50e1x6r7HYnyFA2U2/b5t51wi5EDxT8MbQMyjdqRBjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199536; c=relaxed/simple;
	bh=4vHb/e0Kpp9FikZJirZ0eO3cVqqiZE9ibnExEMgiK+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hRSVUomkxw23D8o/5lMM6lNobDkO+yleSZwCd0jedBwnEvftZToFWQUQ+EPkxtQGH+99KfP2DaJaj4XHS6MjJ2zX+Sm+4zLt/F4EUJq0NC1aAal+xPzcqOs66Uey98VC9vY/S505IZ8l92MK8KjACgoiIDdbNuk53FML9pKbX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BhD3f6Fv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so254979639f.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746199534; x=1746804334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swe/trEBPnb/cRsPYQHbOe82io1cAUpgTTADUGLC8hA=;
        b=BhD3f6FvUFJ3KwquWL40SHIbEOlHR7pCxqQg13q/jTJpAOz5HHuVywqzyHhfeXclGT
         kLQ/n61+La1t/nLzLXsfb+HN60NpSfaPyITkdbmN0Gxxv2s4r79lVpwlU51Ng7aE/Nen
         LACX504q419CRtJKzBV3dOOi7siiu/nibQrmbToJICiUpWUdX4KHla3sPiAWmW6bFhkv
         a7Z8SqE4p8+JgnqoPsywSRdbhgLqWNYCo7ysxH/AOvWeAnrooSkX6Yd0/4Er9TXrzcSv
         wq/b9hrZ4lUQTtaX0kl9oN+rZM7+t9xscQgnzwGNYcGP1wFKxpOKIjhOFy7u/bM5bWNO
         tVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199534; x=1746804334;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swe/trEBPnb/cRsPYQHbOe82io1cAUpgTTADUGLC8hA=;
        b=HmS3tX/sLS5J2V6eSjtl7IKukiOoa26mI/2R/zRnxVoWnkYE/J2iILDQfjP0LubOya
         eknk1fyhpTRcB15Rg/Kw3NAccge/WlLdTROd707qTLi2mEgxjg5aELbMC+sZLlSORhPq
         aTKv0ZgqzOBVpoD/BfP8I1v8O2149WMTPKRXxphInE21dto/RhOr1IyB2/dcVoYBy+3j
         qhY0jn0e2B1w9sp2dafVKSfoWkFrCX2zLrspU18Qx+6Xc6QnOTM+X2UE6Ei7q+akQq4w
         NbCmp6K6lbt7pZbM5aEAL8wLD/dfyIVZmm0jKPtVz5a0GxIzQh4frklL8JeuFWztLWtb
         URog==
X-Forwarded-Encrypted: i=1; AJvYcCWwCSbvZ6gY5Wxmbl9Jsh4bPHHbyHKQ1e/Mhtl7lNZeGChx855SJHZ1+wSolOZ6mS9LZFWO7Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWT2oeiL0rq2YjD11EoQcqWaqDMaWRAWP0wIruvMASZLjF0Cd
	4VFIaSgK+d/pM/sK/y7veR/iH45Gck3QtvmQcUddRDP3LA6kNpzBJgefwemqhkumbcN8VoFT7Y+
	R
X-Gm-Gg: ASbGncsDRqn0fzdE094HxXuBztI3DvHfoeVssgO3Pc3psRrUXfJojdTHNE/j81RVW/Z
	pvpSmMgsohkhPcqBpwqs0B0aKglU5oER/d2wCtU010AjJdxn/WR3AEIlUpwUbsTJvDnBsUQrOJT
	3/qHT2M4scqZibRMiV1YHRjGrPDIoeefNjvOtfJeCnYXRm+tbRoCXyqFCbLN2S9YEcv9Tds2jpd
	D3KMvh12WUkX3k4i0xD6qusDOOd9IcJP1rhv+NzY1P4HYr0uPkWGBC30htn3cgZB39NMV/5iT8i
	IpXZCUIp9KSOna/GPNsVIg2oAVDnufaqMAU7mq1IKg==
X-Google-Smtp-Source: AGHT+IHny6qzFoF4mOzb7RBx7VS6edPHk1SLaBvgePlKlF87WCO8sxdJxrc2DFrFA1MQ2Kk3f5ESWQ==
X-Received: by 2002:a05:6602:3687:b0:864:a3d0:ddef with SMTP id ca18e2360f4ac-866b343cd04mr445111439f.6.1746199534158;
        Fri, 02 May 2025 08:25:34 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8e1f7sm429300173.121.2025.05.02.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:25:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
 Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <cover.1746097431.git.asml.silence@gmail.com>
References: <cover.1746097431.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring 0/5] Add dmabuf support for io_uring zcrx
Message-Id: <174619953298.748556.14620839074775551188.b4-ty@kernel.dk>
Date: Fri, 02 May 2025 09:25:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 01 May 2025 13:17:13 +0100, Pavel Begunkov wrote:
> Currently, io_uring zcrx uses regular user pages to populate the
> area for page pools, this series allows the user to pass a dmabuf
> instead.
> 
> Patches 1-4 are preparatory and do code shuffling. All dmabuf
> touching changes are in the last patch. A basic example can be
> found at:
> 
> [...]

Applied, thanks!

[1/5] io_uring/zcrx: improve area validation
      commit: d760d3f59f0d8d0df2895db30d36cf23106d6b05
[2/5] io_uring/zcrx: resolve netdev before area creation
      commit: 6c9589aa08471f8984cdb5e743d2a2c048dc2403
[3/5] io_uring/zcrx: split out memory holders from area
      commit: 782dfa329ac9d1b5ca7b6df56a7696bac58cb829
[4/5] io_uring/zcrx: split common area map/unmap parts
      commit: 8a62804248fff77749048a0f5511649b2569bba9
[5/5] io_uring/zcrx: dmabuf backed zerocopy receive
      commit: a42c735833315bbe7a54243ef5453b9a7fa0c248

Best regards,
-- 
Jens Axboe




