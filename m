Return-Path: <netdev+bounces-124612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C036D96A359
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C09AB226E2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB96188589;
	Tue,  3 Sep 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StU98JOn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086B2A1C5
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378776; cv=none; b=SFiu7jy+T10JpGCKs/+KsKtEc4xMpUHUUqO1rLuTogN0hVTzDn/tEJEqJjS/lfiiTWa2Q0+FyeW0/952A3I4zj7PWrkm79Db5NktzXGQ9pfMaSAjmGOQYrr6IsapV400oFgH6uE3jDYLyle/xz7yvJaGcvW8I/vEdKNWcGc0iBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378776; c=relaxed/simple;
	bh=CHcQJ2a2x9//t4Oh3U005qFxvmJfEecXGPQ05JqX3Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+T6mqRZspBs7TLzfaSYJE00dYZ4wVRkd5ka+vmEwFH0lPZ2wJoME4Oz4JsBExTZ1w/i4l3ffML1ynS/QUK8S31pQ5LaaJB77yGO+C597Nd/s25uye5gppKi/HI1tp8YbeGZzFiTjw+PPpAiXWVxY7MMY1jn4kfYl/4MPMJ6njA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StU98JOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725378774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sBAdtjRBVCnxbHCGrxjOskKrQMu0Dol3IP6QvAg8yWU=;
	b=StU98JOn0XjwDiAK5BWdR/pNxrc0KEU2CpE8r7KTuz7sEQ1vL9DUlXyX7vSUkvQhjBNLU6
	fDRtF93lvWqEPZYtWZbSFqQwDST+xQ3uiMUVIKp2D5NT3JeDL02PM8fkm03b6g5v+Ht6hV
	6aJmOvOjM8w7k5x+CyOYDy1ZBqibajk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-NkG5qnPJORuAtSXR0giuAg-1; Tue, 03 Sep 2024 11:52:53 -0400
X-MC-Unique: NkG5qnPJORuAtSXR0giuAg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c3a31ebcso1753803f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378771; x=1725983571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBAdtjRBVCnxbHCGrxjOskKrQMu0Dol3IP6QvAg8yWU=;
        b=Y4nKKz9G0JQgnDaemsxmy/R57jQEc27pgtZ/YtWleDKNu8jmdp3F8oIJlxBoMKW7oV
         UZtnjodOpg6BaIByBkXWj7RO2W3vtZ8cqp8JJdJstmwhy/tfMFuTieXQzfAK9wsB3tXb
         waqx+4E3YfGbuWMrhZyahrqxRgLmX+UlECTjL7tS6uAGE1iBgyZSEH+1W8Sc0xxUX72p
         yvdyYptvOYMcbhBMXX+VIylIYRRRehXLmMbCzPzOtthTzyFX1jod1zY0RQHK07BqeaA6
         V1oxBZlx/e/G3LnNF2qSLiPTTsp8lK3c/vedvU8n0h+buWORaIB48t8Ne19PRf0onu9E
         TZ0w==
X-Gm-Message-State: AOJu0YywE7wLwzHtbxjXE7vI5o+iAwWSV7WOCGQXqWk4baMn6cinuk9o
	S62YGL5z8BSlUx2ZvjXQPkzZ4manpxlGytSwEJurhfV9QfB3cg13SKpDxeHSpwZZOaffeMTC8Ib
	g3X2vqL4KIhGBWXpesdxddv2O/CvTtMnj8cCAg/S9oxKtIzDbk5mCwocRsO/v3A==
X-Received: by 2002:a5d:42c8:0:b0:374:c040:b015 with SMTP id ffacd0b85a97d-376df005533mr837120f8f.57.1725378771040;
        Tue, 03 Sep 2024 08:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwJ048wsLm7wbKsqZyc4sp09arVu1N/ju19zugicnRsaNOm422oNXkuLTI8TOH4FvrvHaCVg==
X-Received: by 2002:a5d:42c8:0:b0:374:c040:b015 with SMTP id ffacd0b85a97d-376df005533mr837108f8f.57.1725378770162;
        Tue, 03 Sep 2024 08:52:50 -0700 (PDT)
Received: from debian (2a01cb058d23d600f5dfa0c7b061efd4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f5df:a0c7:b061:efd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396516sm214046555e9.4.2024.09.03.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:52:49 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:52:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 1/4] ipv4: Unmask upper DSCP bits in
 __ip_queue_xmit()
Message-ID: <Ztcwz14WPh4Q9hpZ@debian>
References: <20240903135327.2810535-1-idosch@nvidia.com>
 <20240903135327.2810535-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135327.2810535-2-idosch@nvidia.com>

On Tue, Sep 03, 2024 at 04:53:24PM +0300, Ido Schimmel wrote:
> The function is passed the full DS field in its 'tos' argument by its
> two callers. It then masks the upper DSCP bits using RT_TOS() when
> passing it to ip_route_output_ports().
> 
> Unmask the upper DSCP bits when passing 'tos' to ip_route_output_ports()
> so that in the future it could perform the FIB lookup according to the
> full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


