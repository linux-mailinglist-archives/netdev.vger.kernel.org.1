Return-Path: <netdev+bounces-75314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E745A8691A9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249801C231C9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0B13B29C;
	Tue, 27 Feb 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nV6iojVL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC113B79F
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040223; cv=none; b=j7X+fwiYhJg5NqOusKzbyk7q3drwcTMd1C1c8AI92qGcBlcql9LDGJGQacgLqvnZpdd46dKEDrngaU4ETOE+OXXwhZT9GshK6LSK1AaCn5iX1gBDWr0ZomQi1F6EYrPIKi2/nWK+nSq1qCzMR4/1GDe7fjUcEXmM4fd2dsVz5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040223; c=relaxed/simple;
	bh=UIELqrAjJbz7rdlwdI1d6a/VDVzleOGjv9AG0sxZGlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlD8YZ3yPreAnAUoKp5S3HMzxkExS1l8Un36hiKgaqBMaqLssevd67ptF2zErR96rj9eHns7HlywI93gkpp8WBJwdhyObM6huU5YBtPcQQGa2t1+7U6yUh2HZOSoAmPT3BvY1zfJ1AOirJt9MaO+7QhNpQ7/o83ESfX2ENzGrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nV6iojVL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4129e8bc6c8so23873745e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709040220; x=1709645020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIELqrAjJbz7rdlwdI1d6a/VDVzleOGjv9AG0sxZGlE=;
        b=nV6iojVLFUMlLkp+ufC7OEhsnNJNFzZ4FWTI5cl/iMMwq2xazqctVvfmDmqdxttKb6
         9oQnb5gZS5mDFncxSgkoCG4UEcVe9uF/frSOWeO22SqcWMU03j3JlDM852Ck1gGxpp0N
         Nas1jMi2hUa6+1iTJOdXFx3Vswmr0nnsW1JUpwkGa8T0PcpLeuecUZBTqS0zeSQ+Jssp
         FoxRpygSsD39soQG5hJxlo1WzClEDIOEY7OrCKbuMkfoV5OyQODwcUkNxMze9uKJQrDC
         m8UPeSyPTwdSCMb8BHVqsD2RG2ptsEwEFL4jCUYuR0qaj1oFRvfJKRXxx/LHGmJOqiKp
         X10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040220; x=1709645020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIELqrAjJbz7rdlwdI1d6a/VDVzleOGjv9AG0sxZGlE=;
        b=TqQBP68MYzhNj3yYqn9SaPrBjn+2lg8YFTq3l33pwi3VKBhIIjOCXa2U54ukyTXZO5
         Nxdz5KXcLv4vKX5QI5hbqW/Cy6YDZQ3VLT+pf9n+kGMLbP4MewFOsTgfRolOnOYlXpCE
         TJ53ZgypjAGlc8WWipXzdOebcFiQpSBnO6kywI4HoBUYnx1AxA34ESzXpM4xF1/6b9M9
         xj6be+EckLJgx+7d78cpUKwZ0PV1VHIyOXEiNeCeLaQuBlnmc95nI1qr5mKiqhAACq89
         kpWBQIvy+frWCmmNuKa/krDhN7lEsLUUfbDWCqRLjbiCKDxIS3n1mjXoXPOP+Zs1wiIt
         4VDQ==
X-Gm-Message-State: AOJu0YyGsd5gKeeszqk52kXgcEHP9UM/bGHmJGS2nE9rFqqH76zvwHnS
	86PIG/4fIPqDioYWuKkBF3CO5pIBANKdvAo/+ik/uwWr+pL1VeXMvoVHg85woZM=
X-Google-Smtp-Source: AGHT+IF4MMY+biBEI84lgrZhaf8tscNysmDzD+JZeZxxS+RTEPp8RpJw1pxkiXUE91IEmAcNraq5bg==
X-Received: by 2002:a05:600c:4f4a:b0:412:9d6c:eb28 with SMTP id m10-20020a05600c4f4a00b004129d6ceb28mr6558234wmq.20.1709040220156;
        Tue, 27 Feb 2024 05:23:40 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b00411e3cc0e0asm11363841wmb.44.2024.02.27.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:23:39 -0800 (PST)
Date: Tue, 27 Feb 2024 14:23:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 2/6] virtio_net: virtnet_send_command
 supports command-specific-result
Message-ID: <Zd3iWJut1tMHRIdU@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-3-xuanzhuo@linux.alibaba.com>

The patch subject should clearly indicate what should be changed,
something like this:

Subject: virtio_net: add support for command-specific-result in virtnet_send_command()

Tue, Feb 27, 2024 at 09:02:59AM CET, xuanzhuo@linux.alibaba.com wrote:
>As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtnet cvq supports to get result from the device.
>This commit implement this.

Again, be imperative to the codebase clearly saying what it should
change. Much easier to read and understand the patch description then.

The code looks ok.


