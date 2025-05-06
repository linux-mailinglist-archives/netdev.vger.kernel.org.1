Return-Path: <netdev+bounces-188239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD316AABB52
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6843AFD13
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D821ADC6;
	Tue,  6 May 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aE84bG0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B98189915
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513525; cv=none; b=CpAHA0XgrnxUC1etkq59hzDDZRvMqPLqb1SMqmilbTtqRzSRFWHZKRWi35HLVpDqpn7MynMMmLfMBfkAIa7zZeMqDeTHh7HMwRdx1IyjDxVu84yGNpT6f8kgH55ZLS20yQo0/IGeOj5rB7msjwwYML64Nt5T2w7N++mXOPJMDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513525; c=relaxed/simple;
	bh=W+8HNXjEiYo9rX5Y/TMLgYKuiGamhrhUXUaab5gFbvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlEKHRZmALddjuqCMLN3aJrJlxEoXg/aKp/rJqj19nvZydN3C4HNXA8Pwks1AE/qivVAsgQX6ELl14kVs1NPbRAQV67ljAglnwsPR/XoPY8ZrTXyDyNj8fyL8WLOrkecj6ECV5ErlRa6BH1RbJpDABJ9Qu1Fswc8vU5+NIm9v8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aE84bG0/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso1341195e9.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 23:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746513519; x=1747118319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+8HNXjEiYo9rX5Y/TMLgYKuiGamhrhUXUaab5gFbvg=;
        b=aE84bG0/OZ0s1qjmpQnS7FH8E1j6/aPQf3k0i2EYVxAQfSwaDurJGRPoD92vMvnVRT
         I3MiGPye5IKqWFuDEpbAOI0h5N1u0laveKQEpjUgg5MQagFof++3/kYyepmF5iEMrHVG
         sj5rD1ZQek9qdXCA/tGCwN9/5ERAw1alZeAA+Ju0EuHLKa+3V/l+qTlCJnY9b9+WKdvu
         OOpcRcZjb0oD4ZcB73ZURgNhmnHmKZgz3LF7z1mFsf5+yGU88pbWWbqemhrXCzDi/MTw
         sJctQv4R4Hvi/Wj/u9PiTGnO0DI9pCql8Kbt552E08Ktnh5QrAulpMLu4pgIx2VEnKZR
         ztpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746513519; x=1747118319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+8HNXjEiYo9rX5Y/TMLgYKuiGamhrhUXUaab5gFbvg=;
        b=U5stNDCA0qFCbe5uW5rNPtYNq8RTkwkMv7YQL5puJVPXnutC3ZatpfqWKc8h+Ns2nr
         iigwQPtUbPOMVcLq4hEiYQ0DLknre99YoMmTez8TM/4szqEdlT8QleY+J/TvKd39dXLW
         9euqJr7H9G8DsOmyqI9qZp749mB/TGQcaK0+VCyM2s1pgW2EiUsD3MvnxLev9m/CGP65
         HSb0R8qVCpCtgqYB7ugoG+xOgv+x6WBL8XGvJn4hxWVlvOiLwg9lsZB5K5Vjddq7ZHyt
         +0RNteEFJAC1kHtE/jcEIWwcT8OjKlciDM0uYEgTj5rEeP12X2RqfvhbGJuHoRsC9tPq
         IqQg==
X-Gm-Message-State: AOJu0Yw8UmgG+Fyd4ybO81WFu9DksiHdWIrSQE8faI/FSRqDAAkk7Cz8
	l6G7biLOCAENTSXdIHLe4BF+zq2+Uo6P92V0PeP25hPSC0lmRXygSrkByfa6N4EvsRHf51jiYPL
	q
X-Gm-Gg: ASbGnctZf/PPC4jZhG1hDczb14dyvpbdEUOxpg1BJhtK8PdJEYecWjNeTgzPYc7HZRh
	Irxt0H/Ogz2H3mjzWk53e4Y6KX5DFOHL3FA7BTsxx+8KtDMou/6uPfGZ39WFPk5fHK644vbbd5v
	RXloH+Jh6uCVQ31VDxv++Lvn9p2S0/wV5iqVe3mYhb3/bVIiEvGwspHHEoVyYAiitWbDFGtEjmm
	Ohg7mAzaYjyrVLHmtf/Lkq3kLXXcMONnAhwnXkEJuR2gcIAkbODdSHGhlaNADgDox5kybI6EjOI
	JqqsmD3Eufok1EDFdeE8Hsbj9MawToW1LgEBObEc/wVfaR3VFYU7LBNEp4TI91B+5RaoAV10bRc
	gL2x6KQn9YodYSdny+S+/YA==
X-Google-Smtp-Source: AGHT+IE/Ig0Bkj9veXbQvcS+Bfum9EL4WpktXIk0c78Y8CfGJYgfCmXHKJs0qCQ6eh+wc3N1rT6Nuw==
X-Received: by 2002:a05:600c:3d9a:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-441d1012db1mr9111605e9.27.1746513519435;
        Mon, 05 May 2025 23:38:39 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0cc9sm12407303f8f.9.2025.05.05.23.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 23:38:38 -0700 (PDT)
Date: Tue, 6 May 2025 08:38:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org, donald.hunter@gmail.com
Subject: Re: [PATCH net-next v2 1/4] tools: ynl-gen: allow noncontiguous enums
Message-ID: <5mgfrsapfnljlminy67o2wnz3iwh3mqba7fazt4ku2v6xh5t4g@nwgn3rdndvng>
References: <20250505114513.53370-1-jiri@resnulli.us>
 <20250505114513.53370-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505114513.53370-2-jiri@resnulli.us>

Mon, May 05, 2025 at 01:45:10PM +0200, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>in case the enum has holes, instead of hard stop, generate a validation
>callback to check valid enum values.
>
>signed-off-by: jiri pirko <jiri@nvidia.com>

By some accident I managed to remove uppercases from this line. Should I
repost or would you fix this during apply in case there are no changes
requested?

Thanks!

