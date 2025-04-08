Return-Path: <netdev+bounces-180427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4331FA8149C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2632E4C08F2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DA23E334;
	Tue,  8 Apr 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCxFtQ/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91A23E220;
	Tue,  8 Apr 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136780; cv=none; b=VZHv51L8UkNKkl7h9r9V6HBUbY3oZG16og6ULEwAvLZIVi7t7npJ5Gs4aLHeABOrpHFvisHEtL1xQ8igS9hhx7LZcr1LdhXcF2UIUknxqehv4C1HI5ZAFMfCZOmFZKD90DcQq43ovHssBPNrI9yls0nK0sHsgyN90khOJBZ11Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136780; c=relaxed/simple;
	bh=/HKYNB/i/ctUd4r0fgvBPDY6vg38lIBSYKJ10RXEVnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0EAst3G3rs+8RN2XLdGWO4gKlrqlTrcR4bugHxtCNbNvsdUgxjUV0FAHBlHZQqq8rhNK/ib55YY45hZSf+bBKsB41A3TTSeotEg7yZg8KQZmK3np2linDE7X+9JYc51tyROvfMV8ZVANx81C7BMvsYDkfYyIodqtVNBKXxLrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCxFtQ/I; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54acc0cd458so7150889e87.0;
        Tue, 08 Apr 2025 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744136776; x=1744741576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EG8hbJaVOVNR0BTvD7eYEE1VvnmYFyZW9r9DtGOsinc=;
        b=TCxFtQ/IXC+WR52b/75vmLLrJsoIvjgAI+fYMq/GbPqtAzn7wSzfTnRinAC3dDi5ay
         FHAz4ZDzO65wlAsVYfUbTf/KcX/RW1aMu/0JMMnzU5miKixIJJgYvv0vPHOp9Z1PJuZc
         StqhwrUcYZKL8lRNe8Jf8yQMPC18Eaql2DAPaaLcbB+Wfp/WKS+h074wELvgjbvtYGvQ
         Funps6AP6j2nZntcJo9Ki7xbGCkXQ7V6cBm6lpYBFlUyDQOIuRlANR4tdyltzSufivIe
         rT1oTkols+uX/yAfawXNBn+6T7tSj48qIqDM4bMa2eIF84BUWcs9K8Hj+W0xQBtBQrZQ
         OZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744136776; x=1744741576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG8hbJaVOVNR0BTvD7eYEE1VvnmYFyZW9r9DtGOsinc=;
        b=FlhDf5sV15TNEwhQxysoEbTzcgU8WdrJQgkl/XcCPMEGBvCykDk+6Zx6JFUmJqnAac
         QKX04Jldz8Ep+SPGfBUr0sq2w4V0jj/pIAL7mIhYE8dNYngbyggQIW7sEnsHSNls+zKP
         LnWyY9pvD3kC/xFM31sDk0dvF03+w3kLTkUwWNNwS+gxAwIh6TO8GZ9cigslfQteLsOk
         fFjfd6sDZuIqS7eun5tZmn603wa88vHjjN9vMMHKSn6bET8FHeJiKaqHdKYh2V72EhRH
         niQlWoETGqIWbbzPEE0PM37YlMa7yJbp0Qa+Vq1LQZvMQe92aIAEw4ykpPmGWf57t/6g
         y+3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsqXGNClRZrPpoIctJiN4D1pb/zxRbLsI8bc/BdCcU3wu52wtNfOAmaup9IvWLimXGq5omkx8VjPq+kwg=@vger.kernel.org, AJvYcCWJtQR4cGLZu7UahBVWyMmKcwcVmA8B2ro+JH73QpOtgRcKCWgYIfSydKyDrihDDDDGfssJ+5iv@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoMNw4YD6F8s1FHBv6mlJ/FVmM76FpEQZ/hparlyAlNBnivUU
	SzIZeilyScGkHue+dqnSptBG32dvH56tK1c2DRq5n8XMOtYcmoIW
X-Gm-Gg: ASbGncugM5GP8vWHRobWqvspKbwsvewjbMEI/pVX9RQqc7WzKVbUZVP5eilqGchlsDm
	xN+Hu289oJamFdEYqth+5gkSY96ExwArfO17KyEo/x2jfxyYyoaYLeLsfdYRr3ozAlIjHsqpVQ9
	XlOley18vgewRPrp8OoTgZ/rC5UaofIPRescJ6R1dfu/jjMdXHrGc4ApQtJWCv41l1bmb+kSz3R
	Zef8bunpGZXOBy8HCBWW9TGA4S3mumUJOw6Ubnl/RuDHTLfPzKFL0o6wyMzsnQ22Oajc9IRKHGD
	NL8Rw5hZwQzM0w5EwSuTHXq8FzYNmiV1jex68LXi99YUxj6JkPfEOcciXk0=
X-Google-Smtp-Source: AGHT+IGjgrnrLyYLYgARYsscRYnkUgSEmQWQPu3Oav9OLlYYy9bEQE69zUTbH/wGlGq8YNuxP5433A==
X-Received: by 2002:a05:6512:1325:b0:549:8d07:ff0d with SMTP id 2adb3069b0e04-54c437c1043mr9594e87.45.1744136775989;
        Tue, 08 Apr 2025 11:26:15 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e65d503sm1605915e87.162.2025.04.08.11.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:26:15 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 538IQBZC024820;
	Tue, 8 Apr 2025 21:26:12 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 538IQASx024819;
	Tue, 8 Apr 2025 21:26:10 +0300
Date: Tue, 8 Apr 2025 21:26:09 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
Message-ID: <Z/VqQVGI6oP5oEzB@home.paul.comp>
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>

Hello Hari,

On Tue, Apr 08, 2025 at 10:01:03AM -0700, Hari Kalavakunta wrote:
> On 4/7/2025 2:44 PM, Sam Mendoza-Jonas wrote:
> > On 8/04/2025 4:19 am, kalavakunta.hari.prasad@gmail.com wrote:
> > 
> > Looking at e.g. DSP0222 1.2.0a, you're right about the field widths, but
> > it's not particularly explicit about whether the full 64 bits is used.
> > I'd assume so, but do you see the upper bits of e.g. the packet counters
> > return expected data? Otherwise looks good.
> > 
> It is possible that these statistics have not been previously explored or
> utilized, which may explain why they went unnoticed. As you pointed out, the
> checksum offset within the struct is not currently being checked, and
> similarly, the returned packet sizes are also not being verified.

Can you please add the checks so that we are sure that hardware,
software and the specification all match after your fixes?

Also, please do provide the example counter values read from real
hardware (even if they're not yet exposed properly you can still
obtain them with some hack; don't forget to mention what network card
they were read from).

