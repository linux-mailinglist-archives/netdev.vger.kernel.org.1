Return-Path: <netdev+bounces-145396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8B9CF629
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24341287FA7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5B1E285A;
	Fri, 15 Nov 2024 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="i431yn2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080F1E283E
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702735; cv=none; b=REnsK2GgBrFIvjw9wPUSIzVRipw6Xhww2LtQyUhsRZz+EkgBcdTtVAoo4ZsRDrJBcQFXouX9aNyy61h4G8TVnO3cyhCyzIfVWKjQMQN6+6+qbyq7Su//yVphczgqlcMgbjUxhr0S3uKs+aF8Cxik0HqOzYfLDoYLXgFbStLkHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702735; c=relaxed/simple;
	bh=VlRSm8MJ70D6RF/SfNz605wFiXzHe0Bb7iXbBH/aFbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvEoTjipzyLDpUYyRbNViHvWyk3th/yOWvJ5QKZxSU88upc65ECcJ9G65NTM4lh34/dq2gFKWq1cYF9C1IlnJnU9TdLqAXknKn/kl35OgNR2AmQejiORnnnMAcp/MV7gBrxRYx9RM9Ez1k4i9cIGwhyp4llNYYYPq3WL1FODrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=i431yn2q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eab7622b61so1624504a12.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731702733; x=1732307533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae6byj492xR7qkk81rknSePZwzM1QlJfDGqk0U947fo=;
        b=i431yn2qHK3fQ1UB1Ft2hsIr2LF5gP2t++BEbghbNSB71xIQj1IpNMqPYf82S+5XAI
         46PE+EAwYjpfI6zkqf8VdsUppGfSv27l++NSHqYMeuCkQzJ8RmL8dqK/o1oA98n9Kdpo
         NXs5u3pbSeOZ2p+h+iaPWcMmGw9IugRAZsuazEaL87yD7+T8ZTMApLTf9CwcFDOmbr8T
         r6TRlXHoQ6DSDvT31qYbVtYd2X0gshELRMIenHtj+cX1OLjHEi9F4PGpsip4ocfcpsA3
         7dA2YsyRzUK+FMqx8h15Smuel6r51K9R9Ns8AMfJdkqM44sahItUbKJwezYp6PIA8Ypk
         zHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731702733; x=1732307533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ae6byj492xR7qkk81rknSePZwzM1QlJfDGqk0U947fo=;
        b=LyiyXtGS4zJyPhFl92E2ZNvy9ZpT9/Y91nolvCA/xHGcut8fbkpzPkU9Dp7MDi5Zzk
         JxmnNTdTW5rU9WpJPxkQVoyWOVppMbJ2v29vTB5VhJK0IbrVA6UBY9DNCgKg1Hcn6G+u
         Wsxpx19Mq5K7BrirC0IrwYOvVsGjb/31CHqPEbegBVQoJ/OrcL2Yh/TJ372lGLQXmjSI
         vgCNuamecWdsyQTnrxTZK587uNNYH+oi1kxNVo+2eFDI0hKfyycnb1K+PM6ekM0ILaxw
         fYcUCPnMnaKSoIUaKaIUJ0CjyVse6jwqB1roIeUwQf9qJ8/i12wOs0rh/ZyhuJiIy6mp
         6rbg==
X-Gm-Message-State: AOJu0Yy0QStzUdXflEvYq2UDYs/IL+W/IypBREyERQIpYOgVFKs/BHXN
	nZkMJCIk8HZeZi/nh9z+UT4UrQmjR26vKmG7z7JUhIQ/xN/0ZkeFpa0xvQI0Xw8=
X-Google-Smtp-Source: AGHT+IFVTaYYuwuXOHDdnWlRGJdplUvn4N+8sHD4u/1+0UgjyJWuWVoxs7CSIAboWCmfjCcIbALW5Q==
X-Received: by 2002:a05:6a20:2449:b0:1d8:a29b:8f6f with SMTP id adf61e73a8af0-1dc90b1cc5emr4661442637.16.1731702732953;
        Fri, 15 Nov 2024 12:32:12 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711ce07sm1790530b3a.41.2024.11.15.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:32:12 -0800 (PST)
Date: Fri, 15 Nov 2024 12:32:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next] add .editorconfig file for basic
 formatting
Message-ID: <20241115123210.752b5580@hermes.local>
In-Reply-To: <31ea1d1b-dbe9-4bc6-8218-64de1884baaf@wanadoo.fr>
References: <20241115151030.1198371-2-mailhol.vincent@wanadoo.fr>
	<20241115085150.62d239ae@hermes.local>
	<31ea1d1b-dbe9-4bc6-8218-64de1884baaf@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 02:59:01 +0900
Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

> > [*]
> > end_of_line = lf
> > insert_final_newline = true
> > trim_trailing_whitespace = true  
> 
> Just let me confirm this one: do you really want the automatic
> whitespace removal? On some editor, it will trim not only the modified
> lines but also any whitespace in the full file.
> 
> This can create "noise" in the patch diff. If you acknowledge this risk,
> then I am fine to keep this parameter.


Yes, emacs and some other editors have bad habit of leaving trailing
whitespace. And sometimes new files get added without new line at end.

Line length should be 100 like kernel.

