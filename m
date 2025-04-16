Return-Path: <netdev+bounces-183150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B835CA8B2F7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DA03B8492
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF422FDF2;
	Wed, 16 Apr 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY4laQ9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039D22C35D
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790908; cv=none; b=IXlBn5FqF5XbFNuFrp8GtUEJrg++GQY7gw6jI8q0Ioh5XTei1DRdP7odKXvmEwgDDigZv6j7dUELTUFXqPd7m5v78Q9xdd1DGx2Vh2wW+07R6jaz+20Yf68KaZKkZtcNQnLumipoULwqsow1/k8POVoMIyo4aKxbC4DxvLkyoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790908; c=relaxed/simple;
	bh=mGNMnbCjqXP/gHKZ2NVu9dmQfyhnsnTRzGQhhR2CGAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUjxwM6d7laIyWbhnByjXGIbJEVFdUWOhAjPGbec4JrWMGFVIaPx6dXCRvbR96w/UV6/1oF9szpNy6FsMR1zr+aSTvvOSPCkVBHEsS9mBSIX8EzmuxARoPxm4yuC+i/2mejn210IBYcwxfmGm0QpWdKjZJXR3Txdx35Ao49wtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY4laQ9o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736e52948ebso7306398b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744790906; x=1745395706; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZv5ekk59AOCNu2Gj1iq9cR5KbzxFK2ibBO3WbpDGwI=;
        b=VY4laQ9ocBVv6FDqCdqovaJ6uA2LkMl1SBoYfVCPmJoWfTcVmrzVgP0GBAER8Q/XWz
         9NphgabGxW+pCtpwmi1W6aM1A2hpZPMoMtWVySkA8/i2pwltjKxtY8LKGuA0n48os1gc
         C/Ubm9SmnhdofUPtFAPJrV20HcuHftpNeYbH5RV+jeHuDx51VF86eVDDWfu5Pjk0IWf5
         N0DJyKqWdHW5sOBSTjJhw0USWsVT8Ai4F4DjVCspGY0R4zsregeUdsQgsp7xmXmOYloL
         6VPctYdixTXjq98CKS+d3T58ZCkhx/IHzTTg3HF7hP7FjEpJ0I4nhMtSBQyccAZw3zqL
         y4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744790906; x=1745395706;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZv5ekk59AOCNu2Gj1iq9cR5KbzxFK2ibBO3WbpDGwI=;
        b=ffvK3CTV8wNHP64kEIIWGE/e9Ki3XbStJGw+0KG4klxLQRjaZNy6IWprNUI8Xv8Y8f
         xsZ5sjorgG8dAWbwqzpP617sAeM3OHjB+YEUsnpn3Y5VVmNk+Gb1I9BDsNlGGDlCo/oR
         C4PQoL88iz13FvuZud8EiEZSIZdo2d3fx1cl13ah0S/U2uAOvMnDZlIvQI8sASmLvo6t
         X7pKGuKcem4e4FwLcYKMgkiCbKt3kZoJxPTECVcXVq/6/6x5jcd8ZVSqpsv7nCRBnMmt
         oBgBBhRothoIxAEE/1w63UdaH2rr3cg7TatyTPfnqcESbhqMF/H6Fp3pwghAT7/6pix1
         hoew==
X-Gm-Message-State: AOJu0YwhKr4ApLX6Mif9h6KGXvHTNQymyzMIQfNgRiwrWGTB35vdispk
	hfgkIhyifdhlMEqR8MULiaSy/U0OZzEZf0GVUAcU2KyvyGY49BDM
X-Gm-Gg: ASbGncuPMt68DPozE2rPF+m9ml1AUsL3cuo7PfidjpDb2N/DUaGljujPp9unJ/4vVHp
	inZs+y0JCxFLOjY6Aq+x1OlpOP7TfTbUQQyUEIW3BUaQvDNtlnrEpZBxUAomqPtf31RMo3Tr5MX
	fDG+wHLUEf+giMxvE/PfwHipeGGbNi8qzW72UXPiJ7m8B21nIBpT47MznRwKsnQ3NKTgzwMSOe2
	9k4mBAD1QCyr887gwy/KnsyABkYfJxhcUQmpFTJkbR0UABnfYbnBQcGMG1pk3LSme91RkZFzko/
	jqGwWAQt9X+XRHu+VeEQ7gcpXrJGYt7Srw==
X-Google-Smtp-Source: AGHT+IHxKc7zWqRlaB+vzP1LWWbPteRwEPL2hvnY3mjis/f9E/6fQ+9L33FFr8LYeIdNvcxXCZb0mA==
X-Received: by 2002:a05:6a00:1145:b0:736:592e:795f with SMTP id d2e1a72fcca58-73c26700d5fmr1253735b3a.9.1744790906476;
        Wed, 16 Apr 2025 01:08:26 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21ca056sm9799222b3a.72.2025.04.16.01.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:08:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org
Subject: Re: [PATCH net v2 0/3] net: fix lwtunnel reentry loops
In-Reply-To: <e5a894e5-5637-4aba-89c2-66173df1a589@uliege.be> (Justin Iurman's
	message of "Tue, 15 Apr 2025 11:29:43 +0200")
References: <20250314120048.12569-1-justin.iurman@uliege.be>
	<m2h62qwf34.fsf@gmail.com>
	<e5a894e5-5637-4aba-89c2-66173df1a589@uliege.be>
Date: Wed, 16 Apr 2025 01:08:22 -0700
Message-ID: <87ikn41qbt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Iurman <justin.iurman@uliege.be> writes:

[...]

> This is currently discussed in [1]. We have a solution, but no
> consensus on the fix yet.
>
>   [1]
>   https://lore.kernel.org/netdev/3cee5141-c525-4e83-830e-bf21828aed51@uliege.be/T/#t

Hi Justin,

Thank you for the link, apologies for the noise.
I didn't look for existing reports properly.

[...]

