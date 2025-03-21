Return-Path: <netdev+bounces-176769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF84A6C10B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7223AA4F8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A41CAA80;
	Fri, 21 Mar 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="I20DCq8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACB1494C3
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577375; cv=none; b=LIfgseMP01EMmEdmyScqpHK7TIc0eNyF0n8e/N29izHvlk8IR/lO47PSiII77aGvkzP4LePIAOBLpOGzsWn5hrFqnin2CzyNvOj+MUYFvBhWoTF3yTuTB/T9Lvnh767hp0JYaBh6wlruBhWQr9rvxxJkRgcfpo0a+XJQBjEmCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577375; c=relaxed/simple;
	bh=EPVbbd0HYaZV3z8eTgXCC6yGuewsSygT/Fx8Ues+2uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZcIZT3HgR8yfRkW39ObnPW5LwsEPqD5Id38+iJADjHk/tncd90R7XPx23JY1qG2/EXwvbpdK4/UYk2F/Ano87OMlGy0HaIUjqrRjj5ImC+xKrPqXhW1AazAqaeH1Imy/QX3NHHo/zvWkljEo73NYg8HD81DJ/ReawM0yqFvoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=I20DCq8V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223594b3c6dso53756965ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742577373; x=1743182173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZldbUtl5x/fPMH33kujZlc8V6fuAG7YPToo76T6Ho5M=;
        b=I20DCq8ViJPYA5uVcf8bAden+wb9xmJeqCd1tPXTQC9P0x4/g8cuENmyC6v+i9xUL+
         0Zcy7EmASzPUddxG0uP5QJRMsGT81tfRzM7Bz9lzBK+dSTsJtVBP8MDIGs1Q7Rwcl76Q
         /jJpt6/whSrEbStTt+vX5i3FfElzuk2aIYxJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577373; x=1743182173;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZldbUtl5x/fPMH33kujZlc8V6fuAG7YPToo76T6Ho5M=;
        b=FwVCoXneY0nL8rqqS8q35pVkytbVN0ofCjRsS7GmgkLSnwdl5xsirjsKkaOn1ZFMvT
         YNvFUw00NyM1iopc6DiJOV83gA590m9KiFzlA19Lq+Edo/eyRer3PN5JNhakxyp+ZpwS
         JkHvsPtFqoVGJcEKIGTw2FGRxDZsEARHm8VfkB3FUuNgTeM9vOAecIlGGNkdCvvBNVJ9
         vnlEVdqj8GS//6dZQD7FqI0PM86DgIpRcvFm4KbJaqZLr4GHhAzEH369X4G1/X53H3yZ
         k10nD0sQNJz/G8ILpZsU2X+wQIjPqpn2tshVUCr+UFqyrw3/+G6Ag1MXzf4KMRdLx+Om
         UK5g==
X-Forwarded-Encrypted: i=1; AJvYcCXhl9bOyeZKi6Iy9iuprGBJiIyImz6t1WRYulKxpvElFRQk/d6QTM2KfxZwOplAdQPbofR6j6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPuhs33WJgwTyVyMoHlbCMd2uGy23HNxeT50pPk76z0CEeKmp
	ZlMs2jSOknWjuUjccVpSr6JWw67XO9tagDEqRWMytETRGisn5IR/ipJoEm2QF4A=
X-Gm-Gg: ASbGncuvj1NmEkLJGxfqi4GmXiRBMJEyb858EPPJlVEFsAal+5l4xXELrWkphUltzO5
	RHE2lHczSAPipTI7uY6BjG3G2/xzpcRb4kOQybfLuOx+2aKEV3NlzXinBzR/trqgkmACDWwz9C/
	H6BsOYXowelRdF11G8TmNlO5t5Q9JPfb3zmfNGIdnaL47RP9wUJMnHGi/dJPkf76x9Rh7lW+Tkt
	6p3YY/moWFlMtoAteePY6JVjJ1Vb2YzqIH8yeuDV8eBCDdYQ8WVOeZVvDCkS07Bh0h4s/XNEVDN
	dAMEnUM4z5JEM5DfsCzJwQvkKpwkJPFXkDCx6kbPRwd2CrrY//zlz98pm4FpRdRoVXrV3SqebSp
	2u54KErrjPYvxj0+s
X-Google-Smtp-Source: AGHT+IGw/IZ0z87rJOk8mgq5NY9Yvo9/1o+0CdR3saluY+v18vu0MxYlCD/NFLZtzvWTa6qO9agjDw==
X-Received: by 2002:a05:6a00:3927:b0:736:ab1e:7775 with SMTP id d2e1a72fcca58-7390562ad7fmr7949203b3a.0.1742577373397;
        Fri, 21 Mar 2025 10:16:13 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd66d6sm2290477b3a.61.2025.03.21.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:16:13 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:16:10 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/4] net: Create separate gro_flush helper
 function
Message-ID: <Z92e2kCYXQ_RsrJh@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
 <20250321021521.849856-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321021521.849856-3-skhawaja@google.com>

On Fri, Mar 21, 2025 at 02:15:19AM +0000, Samiullah Khawaja wrote:
> Move multiple copies of same code snippet doing `gro_flush` and
> `gro_normal_list` into a separate helper function.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

As mentioned in the previous review, I think this is missing a spot.
the instance in napi_complete_done was not addressed as suggested
previously.

Is there any particular reason why that feedback was not addressed
in this revision?

