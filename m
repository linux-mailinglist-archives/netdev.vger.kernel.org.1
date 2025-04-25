Return-Path: <netdev+bounces-186170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C7A9D5DA
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28C83BCDD8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D72686B3;
	Fri, 25 Apr 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tGvFdlzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F19921E086
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621215; cv=none; b=F14vXGd6UFOjoRgC3RYZTMb7w/AKHpzlq6FkCOdlL34MD3LH54zp2tCY6Wg0/szR/3YkTHJnNA4zemhDb5IyUMhxaC3/LgA/sLs1CPPLl0iyNNoh1yvkXalHDD4cy6f+OxFeE1CLr3MgvdAgUi1wtplYCYFhzit021imKhYAoFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621215; c=relaxed/simple;
	bh=zH0Z9CNrIq2JFYPddK3xHTfWACrcBgNc6oHsypCTXDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYr8GxfqBTWTVawpuQR69V8v+AYc/s9YEXWPiCx5lNeDToAlMQZvwlf0ECiPaM2KoW5ruWTSnruwghwqr+zRwFn0P7hjm6xL7miL0w+ZWZeFWg7mEXyqhPwMosR/iflMa0Gt+APHjjGyil6O0MUqjn3Jo/tii2UIZm2Xl5E98ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tGvFdlzR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376dd56f60so2154369b3a.3
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745621213; x=1746226013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBFs1Aba3/qWwmhlt/X20sZ0PZ+HYRGkvQkqUFW9V38=;
        b=tGvFdlzR8Rxu/eXwIjbHBu7LPly4M/Rh8VuivWCqmogg9jo021aGGppn6xutz8pwIl
         XGj4VBK9OmTrcv7boLSiIheKZLD1TDl3ZYsNez1F2h5sW0okcTrdzGiD4PJi1YMP61hq
         iRs1DVnwfpAsWNHOASzQEkdp4j2u+L2c4Yu8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621213; x=1746226013;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBFs1Aba3/qWwmhlt/X20sZ0PZ+HYRGkvQkqUFW9V38=;
        b=wFt8krPXu+ToZu7z/gqTyz+TAp5d9Cx3A4xOdK7lM+AEDh6hHK8piDbobhmP+o/IsW
         +tMbcKugsvnyLMGU5aRignMGpUZ6KGLAj1+Sj1YglT90srVoc7B5aiACVaxd3yBFTc0N
         4ocxnZGi1a200Qe4XOPcQNaYOicN6cARdU6PKC9Zs47M3TT/IZbOvCP5lBRYfvtP8KtH
         lx+pzEwtqiqt3L8eiBTHndkktB5ZkhxvZSmg3NJRUsXdefjKuihNF3jRKzevnceUz2D5
         lDS3lCWMIz88OROELRRgnq2AWMnuvlbzdAjw6ApYMGy0YxWpAxRFknFMvbxSDT2TfstY
         5Aog==
X-Gm-Message-State: AOJu0Ywq+KhsSjwT0yYtdycoD/18WwMbyWiKV6fKcq5UKbFnP7NsJ5kv
	/uKcrbRoTyqRRArijGZGKhgc82X2jBqXDp0GDdGnotrMA9btSr5EPauqrupjGBTKkO0J1/sE2sI
	+
X-Gm-Gg: ASbGncvhkJPHx66IIN9RL9rChuExCR/TAEWdB+i5Ii5ftG85tnGPOkJw37MntqJFT7h
	u8psUpnh4uaDc5ckFhMTrcMlbp+9wu3duhHrdSVAgZpQlI2UV/gaQbcGtZSBd1oP+KHnHaNQBDE
	TU5l6Z5oUedhiPv0XrV4NRVy3eUX0EKwnEqzR1pYSLSYc2Y2aXr2zbpvjTffJ43pyt3scnn9CT7
	PUYXco3Kk6zfYEfBxM+xcFhTN4iOTBNWNoxfc7PipCTUvzov9tv/v2k24qL8JEC6q42ZvEew44j
	1ZqswVXFbg5SNNIh1TC0XW9xXO8iOPXzn6AOtSmI+ZAzePSynAFAGnKxxa59ePim7Tkqn2uDG6d
	Bl4tgiKqcNWRWQVLFJSvOVdE=
X-Google-Smtp-Source: AGHT+IHqucIZcc8Ty6rtuAcdU+zNyACi9qDcSAfMdSJVZsCmIckPwvZAv28BOrId2V8AFnnI0iv8Qg==
X-Received: by 2002:a05:6a21:181a:b0:1f5:57d0:7014 with SMTP id adf61e73a8af0-2045b756304mr6389726637.25.1745621213503;
        Fri, 25 Apr 2025 15:46:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f580asm2867158a12.2.2025.04.25.15.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:46:53 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:46:50 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/3] io_uring/zcrx: selftests: switch to
 using defer() for cleanup
Message-ID: <aAwQ2gH9X3rNLkJ3@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425022049.3474590-2-dw@davidwei.uk>

On Thu, Apr 24, 2025 at 07:20:47PM -0700, David Wei wrote:
> Switch to using defer() for putting the NIC back to the original state
> prior to running the selftest.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/hw/iou-zcrx.py      | 61 +++++++++----------
>  1 file changed, 29 insertions(+), 32 deletions(-)
>

Reviewed-by: Joe Damato <jdamato@fastly.com>

