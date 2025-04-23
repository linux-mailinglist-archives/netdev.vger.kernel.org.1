Return-Path: <netdev+bounces-184954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF2A97C8F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EEB7A1600
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BD263899;
	Wed, 23 Apr 2025 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OB9tJ4Xs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECED2620D5
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745373198; cv=none; b=gMuwzaRbU0kEQj96BsGRebn1nIKdenBv7DnHKqblog1nMikFpbWVz/d0KpFKr5yxyZmCYBWBzK9v38MFYwwNPZ3OpTHFfWbwv9QwAXW1vphUXRmFfZZcXTjB5oF8me8++BDsvjOkqBThb4c0IkSuMHSWTXI1wo9ABTUaozYzh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745373198; c=relaxed/simple;
	bh=YOADREcuXzeFJ/7ogJYsiWtLPdbvIBRLVZcgwkoXONI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnZGq7qlwPDQBq3V+eZ+y16aXpMtxDIoJixMUCcRi0vHTGEbH8mWPyATj8HkaJLD4/zJD2lrovvPlJZPP3XbYI5TbavwTq5oGcmrlOhb6W29bVYe0sYGiyM4vTktoH3YWKP3GvQpQIF8I3zvaR0PoU3BtVmnmOM9krlhHbo8U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OB9tJ4Xs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736aaeed234so4899468b3a.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745373195; x=1745977995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGiT7L93EPMhEGwb6/RngvZihZULdSMhV4XtuXAOh98=;
        b=OB9tJ4XsxdyY/okBWZ+ZgsXXDwRpzO7HaQtbRIYoocmCWVh7+vs2HPWdFWGJLqN5Az
         gXbPkcvzHrc5J2KRgH8IFNYDAzz/N2ABGjKL142XMAWnGwBJISHMO3y0NLJz9LEBqK3O
         QpbGV/id3TOHmTa520zLLQ7YrRtSoyPzpE7Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745373195; x=1745977995;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGiT7L93EPMhEGwb6/RngvZihZULdSMhV4XtuXAOh98=;
        b=G72OClMUvJekdPn10xLxwfs3aQIHjwHIfbLPMndTuP3UETQvQpT6efuMIzuLWkRlXH
         LzrTqPVdW/V+J37vJ3KvacUT2WqiY7qlwY7gIHcodt0+OeV1KWUURi+MGFHaBzy8ZtFq
         RgU6a/bCH7cBfPrIQQbGMn5kd+hAQCO0NXuic1moUUmZLAoQ/khhEaI7PlA41YAhJh0Y
         pnu5FdQ4U+VxbaxOhfIjcD9KfwdU1q306+YxXWX2noaYnHGR6YrSYuJSAqyXZamTmkpj
         HkrHL3NJXklBBgx+ySUkNNAuSIMsMWUNbgGdetgdBux6B5ywz82BFV/VEv/yzjWkKtnK
         cnYg==
X-Gm-Message-State: AOJu0YwTMAb2I+AvgA3IheF1bl7w3syJ/trteyCOFsVPsUV+eMXXWY2T
	gDbLmlEqBTlDNjdy72oCZCmgDC4ZczEC0jSlmRtLtRXcA8UKqHYxCoU2s5vK/Fk=
X-Gm-Gg: ASbGncsxxQuUsjaL7DmRx9tHkT4/u9bZY3YJmg3CRp4YpEjgQxbOD37CvLEH5gSobGq
	Y8I0sKZKxlgcM/lQGpOhin5DBa6Twv+zDrPUkDJMYyR+v7pJTNoE3b37jGKg/Fb5/NPm7F42Ye1
	irGKAI8hfJhfaoZhS73/sq+tsto8ZXA/hXpXP7zMCHLpnjnHejLwNkVuEe/RIlN8VeyHvPoPTiJ
	ixLaidFjsc4WKcfRlX1Tqv6oWwCHF0V+ExRqu3L63nloZaTHDPIeYt3aVCyD0pXTGohSAWqlCmX
	Hx8HXOI3PCtnOdIrdtBPx/CI/c2J53Kwe46+ZdaFOXsVl/aeCcl90dDrCMPTTd5zW0zbiBR5X1q
	l6wU4FeU=
X-Google-Smtp-Source: AGHT+IHB4kTggl2g+HQj4syvd8yW2jw969FjiGdBYuNYXKvY4w6+RCyzB+/uh6VxNaqouYmzneOtFw==
X-Received: by 2002:a05:6a00:1142:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-73dc15d0c1amr23847999b3a.23.1745373195665;
        Tue, 22 Apr 2025 18:53:15 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c0200sm9332236b3a.1.2025.04.22.18.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 18:53:15 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:53:12 -0700
From: Joe Damato <jdamato@fastly.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] gve: Advertise support for rx hardware
 timestamping
Message-ID: <aAhICMrep5YHu2hO@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-7-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418221254.112433-7-hramamurthy@google.com>

On Fri, Apr 18, 2025 at 10:12:54PM +0000, Harshitha Ramamurthy wrote:
> From: John Fraker <jfraker@google.com>
> 
> This patch expands our get_ts_info ethtool handler with the new
> gve_get_ts_info which advertises support for rx hardware timestamping.
> 
> With this patch, the driver now fully supports rx hardware timestamping.
> 
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Joe Damato <jdamato@fastly.com>

