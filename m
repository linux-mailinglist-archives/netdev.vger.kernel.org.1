Return-Path: <netdev+bounces-71172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF68528E0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A376E1C21C2B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3B134B9;
	Tue, 13 Feb 2024 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9cZaY9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B57182A1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805517; cv=none; b=fJr+AYafvgySNpuNDvIxUOBwu0X+kte5yeL+1c6CL/UXvg1fc9d8pwRbObW8FODCOqGr1yFhZZXNpbawzUEy1DzE+Q+rfxeBX3S1D0F2ukRTeUb0BTwNF/176YLrOrXfb2EKxMlgnmqJCdXq0YCoC4WciTxJZ0+h3PZSxuJh3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805517; c=relaxed/simple;
	bh=N4P2e54JNm/ZFJpQteb1g82hxNBpZO8nwsCrOAU8a8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg2ESgUJ8g4fmVT8Vgance94c6l2E18tETY11qFPeETp17UtnNeOyWQY5fk9pccXXHx2qmBcHCY0M6uz2rVu5nBD1iJ8Cv+cBzPBgkOFdTDbMw1ygYU9eyE8ECJdLA3XSrbLWTHdB/e3cx6g0iitfbUSVEBNYiQ/rORKPJazFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9cZaY9J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746856d85so29532585ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707805515; x=1708410315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbl0a2ueJ7JWqPeUA+ceeg9CVPnuTyzQh2WfGEe3KI=;
        b=f9cZaY9JzLVwbdSyhQumy8hnF3L44j+bC4xcuO9ra3drTixTsWYfniEZiTK0wG5JJ1
         jUsGfxBg5eiEz4mxxhvrJ+RcVttAn7pq2S7fHtTb/0gf9mkQVBeiqYjhDzoQeTzDAnTq
         LS/HEOR+UPHFLrYhjxWOYEqDDMAy3wxAL8gUQa2SQcpekv+CvggX7jQhH00PdqECsY7t
         nfrmZp1R/mufwUML1oowAZivfCTOYb0nvW7PuzIVdg7749JelSZrCIATRJmj+Cac72Q0
         OxCtZerJMq2wGUmVrS0Zm13CwuY+qbRY69bPQooIZlgWYxfksIlh/YV7LqsXmI6Mr4xp
         VL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805515; x=1708410315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqbl0a2ueJ7JWqPeUA+ceeg9CVPnuTyzQh2WfGEe3KI=;
        b=l8IJbggTPFiGzgK1Ytws6njibv3gTBtlj4NJP9MoUrfn9ZWL6SMCZawpClib2ADsEw
         oHwdVlBQ8M5rH/A0hKUsfl1Yb4WIvEuu3m8lVgah3HA44jZCcXNnQbl/q/20ZV/DrU/V
         SVC1uCyxDXyIUMzvPm5YAst4f6UoepmQuBM1iTGGtg5ZFTvgJSvS49O/itRpPpk+0SHz
         0vWOjQFzL+p/REjPSqhuKWyLBwezEd/IKBnNWhGLa81qYzfLa6QADwgV9JCaRKiRAMeY
         +R4oFSNJ/4RF0l7WwrDGo3QtjjgDvyrrQA2A0G8trAMXJJqrVyVcQO2227xjUsNuRcE+
         WGdQ==
X-Gm-Message-State: AOJu0Yx27gDNPIAG7xw86vgu+fg1/tI3B3Y13+H3fTUC9v1QvDgbxkrA
	8S1spMNdhDN2tq8dl9upPtLOjHeXzOWMPHjof1ZrPQx1nYMkwmtfNZ4z9lIQztbCTA==
X-Google-Smtp-Source: AGHT+IFpiJEufB9vGt7F2Zy+iyv8A/iBGTf4x4uCql79w24yQD293YAe1ncpmxRnY8u/4NMlJMUTIw==
X-Received: by 2002:a17:903:2282:b0:1db:3004:aa9f with SMTP id b2-20020a170903228200b001db3004aa9fmr1147891plh.5.1707805515534;
        Mon, 12 Feb 2024 22:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHvj4rItgpCEHe+W519ilekjuV4a9s9cJeezj6lXHaAm75b5/PQZTLCGt7DhSbgtxXJXtfZ17nG7WMPg+WvT+H
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903208a00b001d92a58330csm1310067plc.145.2024.02.12.22.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:25:14 -0800 (PST)
Date: Tue, 13 Feb 2024 14:25:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com
Subject: Re: [PATCH iproute2] tc: u32: check return value from snprintf
Message-ID: <ZcsLR7En2BurnuIT@Laptop-X1>
References: <20240211010441.8262-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211010441.8262-1-stephen@networkplumber.org>

On Sat, Feb 10, 2024 at 05:04:23PM -0800, Stephen Hemminger wrote:
> Add assertion to check for case of snprintf failing (bad format?)
> or buffer getting full.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

