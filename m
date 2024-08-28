Return-Path: <netdev+bounces-122862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F14962D97
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B3282A5A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69A188016;
	Wed, 28 Aug 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFBSBUPL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED65B216
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862296; cv=none; b=uEGDvIELvJSer4GrzDlBzTXB4HvgGCSUEuoB+bhnmK7yaHoFc45H/8SJeymGqC2ezDbEwq4F9rqZROTBf38hVplr1pDLkCzvkisLb/6fEEtSgdgqdenbrlhnAKMX3DAV87Hza0ZIEFdIXGbivBeKJ0Pq02QD/jmoalvrR6WX4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862296; c=relaxed/simple;
	bh=oKyyRdP4rSnKI0El82yfBJ9/2em3WkZbT4DIRKvlL9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJaFVpu6GcZWz4sD38Wvpp1PblpesOWA8jV8qcKbM6v3+lQ8iKzE+D/9numzB9aMLUI19EBc8KOwdWHb1auL5UrnOtj9E3yJyHp/flFwljRI3oFj0kHZ0hH92KweblRw64wtjmIpnpclwo5XcjuJbJx7BDEpXxxim66lIcB1cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFBSBUPL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724862293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKyyRdP4rSnKI0El82yfBJ9/2em3WkZbT4DIRKvlL9A=;
	b=dFBSBUPLs6Vgv25z1K+eJjctKlctvnPWNzM8lBrs8+WNFjN09rwSFNsiN7DvmBVbZobkpJ
	IE8uQGNOZmyXBT5ZauiUFZOqi7Xe2XAGFvhvAzYEl0/BPnejWcS+gIzOE2lknBBPx0cdm6
	cWsn9Ts+aJqW5pdqrLJ0KuE1V/4TmXI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-P6jdCsqTOBazqVyeHt6Idg-1; Wed, 28 Aug 2024 12:24:51 -0400
X-MC-Unique: P6jdCsqTOBazqVyeHt6Idg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44ff289fea2so107837061cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 09:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862290; x=1725467090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKyyRdP4rSnKI0El82yfBJ9/2em3WkZbT4DIRKvlL9A=;
        b=wEpVMmuMebo8zWrcuR/3fQ6JT1m59OVlAk+JLhCbhESj8krxVdMDgWlPRteYqGWuwM
         wj5YOd1x26HWZmJ0rokWkOzBc+m8SSCz9CCTiXQ50GO0/OK8qhy7zfESVNdaBSF+YjHR
         EKv2YStuTXdRNzMhFwu6RaLGnyMLMo0nexuCK/nJjLIhLOaCbJcYx4V56Q0mulat2WGK
         m4+s/xRJDnsettw5Ib18P6y26a35rAImI6jmphoIfMyY3TJVx7RujA9H2uu3vSlbHS4b
         jsG8FNpP4yelMyP8TQIOsmfY23OzVbQ/zP9XuFt/dueU5YhLk2lGk+ClFZc1PjARvMz+
         SFyQ==
X-Gm-Message-State: AOJu0YzqyEwJ4yWF6SClrpiMSj0F3vnJrLD662ST0PF/Tbb1bAKZkfWo
	lvmYxC8RJhy94zngcjsfXY6SJLmHYNvX7j0PoTx75RV/w4f8J82Tew0FpvD2xeds26MsiHHqKkU
	eR4Kzxt82Ga/uD7BH6lKwNEUzBgiVCwWvIdCbd9vnjckj/Xh3TyRyVw==
X-Received: by 2002:a05:622a:1f85:b0:456:4609:329c with SMTP id d75a77b69052e-456460936b3mr181490021cf.18.1724862290688;
        Wed, 28 Aug 2024 09:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcg4vHMY+AdTJr/EQ1dajxgeeZ0xuw/jbMm23N6P57VW/SVVNawMULnG+DswPYjr4ENVb4fw==
X-Received: by 2002:a05:622a:1f85:b0:456:4609:329c with SMTP id d75a77b69052e-456460936b3mr181489631cf.18.1724862290101;
        Wed, 28 Aug 2024 09:24:50 -0700 (PDT)
Received: from [10.0.0.174] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfc097csm62814491cf.12.2024.08.28.09.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 09:24:49 -0700 (PDT)
Message-ID: <d47f131f-2bb4-4581-a3cf-ecc2d4e215e9@redhat.com>
Date: Wed, 28 Aug 2024 12:24:48 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v2 2/2] selftests: add selftest for tcp SO_PEEK_OFF
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
References: <20240826194932.420992-1-jmaloy@redhat.com>
 <20240826194932.420992-3-jmaloy@redhat.com>
 <20240827145043.2646387e@kernel.org>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20240827145043.2646387e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-08-27 17:50, Jakub Kicinski wrote:
> On Mon, 26 Aug 2024 15:49:32 -0400 jmaloy@redhat.com wrote:
>> +}
>> +
Does this require a re-posting?
> nit: extra new line at the end here, git warns when applying
>
> BTW did someone point out v6 is missing on the list? If so could
> we add a Link: to that thread?
I don't understand this question. v6 of what?

///jon


