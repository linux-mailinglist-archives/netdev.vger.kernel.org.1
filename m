Return-Path: <netdev+bounces-90552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7E8AE764
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AD11C233C6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39DC134733;
	Tue, 23 Apr 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gPCm6X/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0451332B0
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877597; cv=none; b=J8LXPu0eu7t+plsIx8TsfrAbLzzaiaL0sM7dilB0nszfgh9p0xuXvbckXcC3aW7TXDEHyFu4WpBN13Bqc96MTi/iVeAvrcLOFQJZ1EKCKa9Al5R+7LWRaqDA2/QnBf02ALgEep3TkIpMFlMWSilsCAGTbTjCdr3D+CEfo5UBTM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877597; c=relaxed/simple;
	bh=grwm9HXpZ8bNgqFZwTamq6hPZswUJZHRWpQR6jPcCgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGf60IsSDadZtXumK2aKbeQKAw3LnJRMAFLYD5ZFx/8i3ZM4QsfouYrIlNMJnTTbOVm9e85zWdvqbapxHS9zQQkeSkr+aFpN0/obMiJWoFwq/NTf1hC3I+aFRAZ0U5mPuJySCdXR3KsKEBQaTgRM2D3JQbQLGm3bXvI3UnFzRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gPCm6X/m; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so6804839a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877594; x=1714482394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtNKrVkvv3wQwUeLZfXmzb5Q0GHzil5K1gY3ZsSm6Z8=;
        b=gPCm6X/mQOKQYH5eQn8hp4KffHO79Mpu49w8aIjcNL7hp9ZXFXkxU0tTN7UnMrSGiS
         pnCRTncVMeCIZ5VnP+zOerYj5nTg2ioZX/b20+QWODPsOJjfSZKcKv0gz3TQjD5EW3w9
         lpCPUgzKXD27In/qdiOmhpawtv3YcGLOVtzolsTgsMBKP206fhbU9fFCCtzt6nzkoi5c
         kLtCRbhXmV45OCxfMOGyjuKlAdnUX5Ykl7FvRx4N3Kv71O2VGO5Hb/k6Lb5MdjzhuWf1
         GCcj8s3aAPSksAdSZ7iA4u1x1o+6Nw7+edj3bVVqhBYynmZGiKGWuIEzORAAYffz2R+P
         INLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877594; x=1714482394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtNKrVkvv3wQwUeLZfXmzb5Q0GHzil5K1gY3ZsSm6Z8=;
        b=GpZjFrdug+bgYHx+g6/3oP3yOMGbga5iArJaSJKFsZC3rR3CZBPW4mAeEfG4LoCP9l
         TXSGJDA4Cd/4xtfcdIdt4qrWVvn3pGdcwS3HzW43CGYzI/CSDafw2jYcEbWsIkP+Smef
         8fGRG1DIbCm+AxYHHhufnVBnHfkYgNvdeOeTBsJxmtBgUOBBooHk5xFdGG+1g7TZhDYJ
         ++c9lOUB92YF9r8elHcqNlvUcFGyL3tCVTPc6wT2SPOGplb9/aR6wSA2lvNvzXv5ASYD
         NWi4Y86y/51iZX2M2P8uWwA4O7adGLgo39vi/dGCgZnuD6jn7ifyY71lMIRJteWkXsun
         VrRA==
X-Gm-Message-State: AOJu0Yyy56l7FveOYseSyqqVg36Uy458LVA8Hwwd7lrIXPSbZr0CbM6s
	NQzRRr19WT1j3arQ8h4Bieia04XTS9+dTDa7UnX9RCeIHXzHRkJSI3zn/ac0tqI=
X-Google-Smtp-Source: AGHT+IEfj15fF7r+4JoIHYXpZkv3IMh0LCnfIlqWJ1hT3PKS6rWFiI+6gS+uY4CKIniCYg2L0Kg/iA==
X-Received: by 2002:a50:d542:0:b0:568:cdd8:cf60 with SMTP id f2-20020a50d542000000b00568cdd8cf60mr12887790edj.8.1713877594441;
        Tue, 23 Apr 2024 06:06:34 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id et3-20020a056402378300b00571d8da8d09sm4806843edb.68.2024.04.23.06.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:06:33 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:06:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support to sync link
 state between representor and VFs
Message-ID: <ZieyWKC7ReztKRWF@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-8-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-8-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:53:59AM CEST, gakula@marvell.com wrote:
>Implements mbox function to sync the link state between VFs and
>its representors. Same mbox is use to notify other updates like mtu etc.
>
>This patch enables
>- Reflecting the link state of representor based on the VF state and
> link state of VF based on representor.

Could you please elaborate a bit more how exactly this behaves? Examples
would help.


>- On VF interface up/down a notification is sent via mbox to representor
>  to update the link state.
>- On representor interafce up/down will cause the link state update of VF.
>

