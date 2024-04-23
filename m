Return-Path: <netdev+bounces-90605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845168AEB1D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60FD1C21F46
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7C13C3E3;
	Tue, 23 Apr 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3XvHWjB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167513C80C
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886222; cv=none; b=udKNOah4s6PDoZkjxe8hX5nibPOQVcuGUCQvUk5LbDFotTHzCyrb7YRbhtxEznvjOy6cThaTKifl1by3OHF1gLp8K8HOt1kOy4edMWiHs/+zAw3AFEN/0qUBvH52F/DGG3pw7++X//wb5EfAMNF3H7V4BaeX8JjdbICroLmvaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886222; c=relaxed/simple;
	bh=e8wuBSzLvfX5kN29uOikR0cOQbSak6iCsOgk+EzmlHw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C39ukT2U9HCqRl3qRqmmlgLobO+BitKglnT73T63vvWNrfZE2h+gDqZCxuxO3iF/J8viixrSEu7dNZdG6JWFQ1uVxI0D4iSyp7dArR06mZB7qNodL6BCd+1ygQZwVIuPLM/PnT/QYvA+skFO0HMWhlvdroqDzyW2gQv+eaLOf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3XvHWjB+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4187c47405aso39376675e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713886207; x=1714491007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PasE5zHDUZQpfPlcoJSnFo4u5YpglCrOsGZQUACmWk=;
        b=3XvHWjB+p1nZ+ARYiZ78mlfiCqD69ReM4nUeAQM7zzz5Z5QdtsssyIPvW4sV/tLQYD
         vdlzxZfoP+4FO2Ky8lXylnWQ5BU/Di3IJQ///cDmIME8ERbHAAw/BXkhb54Kcl0ACS5s
         airV5cngXPfcCdG5nx7lLewxHWGBqrda1xh6R39DIDi8a/wIw/1kBcBk7QeL2ZyvC2Hq
         rGdCHqKovVfYE3O/cbYPL2MT+4DUOCDj+fqc3cI4ziGdtTa93skPz6YUzqBYKZLZkoP2
         9YMqL4mAqqXRg+7ZHkI8rf7F8XzD/uoSpJtbCD0ZMTzE7Q7dc9j4Gol8x//u75H8RTm3
         JLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886207; x=1714491007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PasE5zHDUZQpfPlcoJSnFo4u5YpglCrOsGZQUACmWk=;
        b=S7w0Ub8FWpxBzKPqBqp5Gd47N35xE8B1hHFuokHua2vMOl8BBaaaIUOA0x9VqZjHcK
         rRWDqO4BfWdpxheYEH6Lweqi+ejNMMUy5GiImlj3ibWkkTIY3bGkK7nTv9QSF/jaiM9x
         GldQS2Msk92BceDzIcdHFun2gD9IS/FhvDZHzlZtjb4QlNEDRHJSjGEsGkAdWWUfux83
         lj2g1oiQ5mKGoKyi4EZbQvZVmPiSXSj6uPBGxey74hBemp5+7On8DW6O1GwuU9zkLWKO
         PGq271TQyRWAgtkCOew51sKpfpcRZ4QsZt9Kj6P9MLSIYMTl5x5I+M8bxi6oEpc8tUU7
         nQSQ==
X-Gm-Message-State: AOJu0YwOLlsFShGEhTZDQ1ub3s+XpKoJbtHCAdopebz6h00VfoMSwvL9
	UGAeqteyZBiWl64ZjSdpfOTU0dDRBrw3/r1KcPNraQcrUEEOdGkCTd3pWjYl4ut/LLLqhrFs1zd
	F/lg=
X-Google-Smtp-Source: AGHT+IGtEkEhcb5mQc3KY/J9uWfPMgymkhpoR4p6Es6H93bP2NJvAnRHhoqtAk124PPyocNsK1fuzQ==
X-Received: by 2002:adf:ec4d:0:b0:34a:2852:f119 with SMTP id w13-20020adfec4d000000b0034a2852f119mr8476258wrn.36.1713886207063;
        Tue, 23 Apr 2024 08:30:07 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d48c5000000b0034afaa9ca47sm6577931wrs.1.2024.04.23.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:30:06 -0700 (PDT)
Date: Tue, 23 Apr 2024 17:30:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <ZifT-pli5-3KBd2i@nanopsycho>
References: <20240423102446.901450-1-vinschen@redhat.com>
 <Ziea2_SRYoGcy9Sw@nanopsycho>
 <Zie9ffllQf8qxv2-@calimero.vinschen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zie9ffllQf8qxv2-@calimero.vinschen.de>

Tue, Apr 23, 2024 at 03:54:05PM CEST, vinschen@redhat.com wrote:
>Hi Jiri,
>
>On Apr 23 13:26, Jiri Pirko wrote:
>> Tue, Apr 23, 2024 at 12:24:46PM CEST, vinschen@redhat.com wrote:
>> >From: Paolo Abeni <pabeni@redhat.com>
>> >
>> >Sabrina reports that the igb driver does not cope well with large
>> >MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
>> >corruption on TX.
>> >
>> >The root cause of the issue is that the driver does not take into
>> >account properly the (possibly large) shared info size when selecting
>> >the ring layout, and will try to fit two packets inside the same 4K
>> >page even when the 1st fraglist will trump over the 2nd head.
>> >
>> >Address the issue forcing the driver to fit a single packet per page,
>> >leaving there enough room to store the (currently) largest possible
>> >skb_shared_info.
>> >
>> >Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
>> >Reported-by: Jan Tluka <jtluka@redhat.com>
>> >Reported-by: Jirka Hladky <jhladky@redhat.com>
>> >Reported-by: Sabrina Dubroca <sd@queasysnail.net>
>> >Tested-by: Sabrina Dubroca <sd@queasysnail.net>
>> >Tested-by: Corinna Vinschen <vinschen@redhat.com>
>> >Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> >---
>> > drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>> 
>> Also, please use get_maintainer.pl script to get cclist.
>
>done and done in v2 (for which I forgot the "in-reply-to" now, d'uh)

In-reply-to is not needed. Send each V to separate thread.

>
>Thanks,
>Corinna
>
>

