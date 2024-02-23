Return-Path: <netdev+bounces-74254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 743E68609E4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 05:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F00AB26AA9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83DCA73;
	Fri, 23 Feb 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEEEZ/+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C9B653
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662763; cv=none; b=aEkPuQmVuKLImzcc/oFjoBZRVtkNM0S4o8xC7J6UY75kJ9m5NN3CwOL8hSbuJ+r8YQUtsAiv8SxINAigx1rXEeR9aqLhPg2NdpyGuP0AwWMQbLnbuSCmrg4oQyfE66ViTkdlFQQOp8ycQ39ozi2PgPsUij0bU6LJDVHUrC+6PNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662763; c=relaxed/simple;
	bh=8BZbnY9jI009PGgVvz1Tocb24akIgTaDD/fuXWwhv9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXwGiVtmqe34RYC8wWcoFTP9X7zxhykAeRfQCiQlgw9CHBhEjr2h12w8mPSDJFi6bK6WZB5au4lR0Y1mzX7vOV8B1ROvsYEryDkcafD2tuAZCudGa/peC7f0EgQWX4dpF08hidVAQQq0qt30zKFTWnMDKQqWcI9uRiTWAxwTezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEEEZ/+x; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ab197437so8364357b3.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 20:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708662761; x=1709267561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Uk3bycxvUA/77qIVLpgAVW1f2vnY0th/QlZtNBt50=;
        b=YEEEZ/+xRiSxmkFwnpwoUBLUDq5AEs7C+UBCRaCUmS0sJeZ9SVeGgIJIfh0A3edjdQ
         qhyeD26L/WHd8+TPeCHa+K03Ep36cnWDH7fZffcO1raNjRF8xFR+04STQ1z2QYo/nFu+
         QiURJ7KjEh6F9q1TswdGoOKF/x2yTyz7Y8J6u1ygrpk34coO3JdjWa3u/iXNNK0uN+QS
         1rlFT6pwUGRYAPD2EkYQqip9PSpJBmQDYMoZepV92k2/pEr4FAy0unmWB1BWcq8x5uuM
         /OB0akEmAnTssuGwe5L+1uJmQumNHbdHU2OgR2/cAJ8mCkA/aMd039FLhGS663xmLEzm
         nS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708662761; x=1709267561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Uk3bycxvUA/77qIVLpgAVW1f2vnY0th/QlZtNBt50=;
        b=cG3vWnyGIOYnRup/8LfcjdaZYKV4PUni+8OGzbd7F/BoPnH0dU2t83aeU6Ngnefy0d
         2tlRCjDDJo4HSi1jsdNWyW4Qhy4S4DmZn7ITFUFTvkgj5qM3r+DT9HQ+3zVQKsplwHaX
         Ed/FwB9El3sdR1M8lVtnxp55nzJZCW/5liTFI4rLXkzcCZSBSrwReNxPtwzk8tk7Vhow
         wS8VmqY0B9XMtTVtiRoQ9GMsmcudBpUASNQXFRh99zDx+JjAUstpodinnfX+94XYUIhV
         5hFMvUS2TobkNfGcEqvfahv9HdYFzEQVZCVohaMgAvh0f37jmXy9y5ZP5xSrOFHS2FPa
         nd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy4tHmru9XqfInl5U1AB4XaS4Z/pV6PXyFwMVfvviam1VHsPi7kBbCVWXIuQgb0x8gm0azyhxUHBGDK/M9dDyhsqlFHTYe
X-Gm-Message-State: AOJu0YxwDvIqQoJ1SFmbNiTkXeyq4EeSHeHRrUnnEpz4X0iJS2MFC7/J
	8TiItzsuwnA2aUUseatgpCdzGyMbkLRhwZ34Qz9CCzNPf0755JWfBNW+ZJAnW/gsoA==
X-Google-Smtp-Source: AGHT+IH2A95OICnjSKeqiYFDzsIlvT6yo3YQAvN/ckMIuuKIGx5hV1gcqvZ3AUiVBh65C8Zxq31UsHw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:9a48:0:b0:608:a8da:1caf with SMTP id
 r69-20020a819a48000000b00608a8da1cafmr317117ywg.6.1708662761200; Thu, 22 Feb
 2024 20:32:41 -0800 (PST)
Date: Thu, 22 Feb 2024 20:32:39 -0800
In-Reply-To: <20240222174407.5949cf90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222223629.158254-1-kuba@kernel.org> <20240222223629.158254-2-kuba@kernel.org>
 <e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com> <20240222174407.5949cf90@kernel.org>
Message-ID: <Zdgf3EkGEWRfOjq5@google.com>
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: amritha.nambiar@intel.com, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, danielj@nvidia.com, mst@redhat.com, 
	michael.chan@broadcom.com
Content-Type: text/plain; charset="utf-8"

On 02/22, Jakub Kicinski wrote:
> On Thu, 22 Feb 2024 16:29:08 -0800 Nambiar, Amritha wrote:
> > Thanks, this almost has all the bits to also lookup stats for a single 
> > queue with --do stats-get with a queue id and type.
> 
> We could without the projection. The projection (BTW not a great name,
> couldn't come up with a better one.. split? dis-aggregation? view?
> un-grouping?) "splits" a single object (netdev stats) across components

How about "scope" ? Device scope. Queue scope.

> (queues). I was wondering if at some point we may add another
> projection, splitting a queue. And then a queue+id+projection would
> actually have to return multiple objects. So maybe it's more consistent
> to just not support do at all for this op, and only support dump?
> 
> We can support filtered dump on ifindex + queue id + type, and expect
> it to return one object for now.
> 
> Not 100% sure so I went with the "keep it simple, we can add more later"
> approach.

