Return-Path: <netdev+bounces-143893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6399C4A9F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC43B227E4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470E1EB2F;
	Tue, 12 Nov 2024 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Zy+aL1Mm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039954879B
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370509; cv=none; b=FXKGRijFYRwxcTD5LZKFELssK/KiF83JoB/w85HlFdACvqsD85dey8a9xouZKG4+XXjwlMnKinsuU1HdQ48mMT3NtvW9VbCYu7Xbadc9xmYo3fOuXd8+czgX8DlXqTXlzxOEqOeKgJWZN+nq97TWD4aBm85+S5158fKUJD91x1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370509; c=relaxed/simple;
	bh=pAJytu3bbNTGxdvSfv26alPURMBlGfNV3WRynyLWi7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQkAMUeU7PZuiS7w2XnUZr96zWtBkUZk8Q6dyJgT0g7BvGNzhpWxcNTD22u2lXheg8GLRY1b5Ppo2zvbWy9EZ+fWNJNQ0UJq0M4WYADpaat9uycJVdtNkmkHKvnOHkHH3+B/Z+9/JLTJhZa3HR6m4CvDCirZKfQ22lM5zEOgyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Zy+aL1Mm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8c50fdd9so41079575ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 16:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731370507; x=1731975307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAJytu3bbNTGxdvSfv26alPURMBlGfNV3WRynyLWi7E=;
        b=Zy+aL1Mm/hXBu36yeNjvC99KVVu3raDO1fP7e3npRyvBArMDFtWXh638xXCRqlFv85
         5/j7nwLey6+XHzMPe7uhFN3GpG6bNk0tYMwULavK1Kybeo1MrOq3RUiI4jisytwpy4Jq
         mLkU8XKGDc0zFg3vIEySONg7tqgD0FN+yk3WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731370507; x=1731975307;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAJytu3bbNTGxdvSfv26alPURMBlGfNV3WRynyLWi7E=;
        b=G1bxrenj0ukz//1HYDL8IEpE3oeXfLzbVxRvHEzqoKk/X+XREBoqwJl3Hz7zPEyQKs
         2A5XS0OjiknaKzg2CD0jCMnvJdLBYgE9WJS4wyL3nfXqwAX+df310Js+fR6AL39lHxf8
         xQdLr/16zrnck6AAKx/SROMbX/ZiVdlY/lNPn60u+Q/MNfsGm46AiTYRGvYuWGDylOGy
         N8UFmROXD/gBeZf4mzaVQQVslNBL/aTsjBWCphxkcSpBSImLEaiB5TgC25RV/tsDPZFG
         jS7sAMR1nCw4gDXYsJ9yw/vv7Z/KAC8gwDKrc/mWB/CcRJtWAi1G2HbwHu5nEqrgyDHP
         lzdw==
X-Gm-Message-State: AOJu0Yy4AKd10rmD1+tjHKSHDYzInBx8X3IPQHVAO2LrWOCpMSuPvdti
	dsZV2HSL4PO1Yfqd4/dWg+hUG7kLyJxEvS8x6U4lgTZ8+Car5LtBbVgYu3dk78c=
X-Google-Smtp-Source: AGHT+IFKLRcira0M/l/zTbkyL1Rk4QR9G6rkQlsJ/FVWGSD9b7xJxC87jZ+AeMsKJ27ibV1kZ/+VQQ==
X-Received: by 2002:a17:902:eccd:b0:20c:e169:eb7b with SMTP id d9443c01a7336-211821c16e2mr249663155ad.14.1731370507109;
        Mon, 11 Nov 2024 16:15:07 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e419a4sm81967435ad.149.2024.11.11.16.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:15:06 -0800 (PST)
Date: Mon, 11 Nov 2024 16:15:04 -0800
From: Joe Damato <jdamato@fastly.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport
 protocol
Message-ID: <ZzKeCJZoEIFoiJyO@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234006.5942-1-ouster@cs.stanford.edu>

On Mon, Nov 11, 2024 at 03:39:53PM -0800, John Ousterhout wrote:
> This patch series begins the process of upstreaming the Homa transport
> protocol. Homa is an alternative to TCP for use in datacenter
> environments. It provides 10-100x reductions in tail latency for short
> messages relative to TCP. Its benefits are greatest for mixed workloads
> containing both short and long messages running under high network loads.
> Homa is not API-compatible with TCP: it is connectionless and message-
> oriented (but still reliable and flow-controlled). Homa's new API not
> only contributes to its performance gains, but it also eliminates the
> massive amount of connection state required by TCP for highly connected
> datacenter workloads.

Quick note for future versions:

Consider adding a changelog to the cover letter and to the
individual patches which change from revision to revision to make
it easier for folks to follow along with what changed.

You can find more information about this here:
https://www.kernel.org/doc/html/v6.11/process/submitting-patches.html#respond-to-review-comments

And it might be helpful to take a look at other series on the list
which have multiple revisions [1] to get a sense of how others
typically do this.

[1]: https://lore.kernel.org/netdev/20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com/

