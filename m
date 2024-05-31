Return-Path: <netdev+bounces-99751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62968D6343
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25380B23E4E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F766158DD6;
	Fri, 31 May 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0FlPk3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCA158DB2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162913; cv=none; b=CHg7zVdFhPpqFBZ5JlbSkchFzn3F1SCnLBU4lwYnCmsJbrWbYnyRAHaEFEX6+tt3azH4+QOBKdu6w1FVav8golv9hlJqcE/4SRsWPSbbNzx6E/ckTaLB3BY3JDSI9vPzWIPzYz4KHsI2ptIbGIq/v+Tn0+GwGIYTTkx6FMOAdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162913; c=relaxed/simple;
	bh=czw/BKapFhZ13CUeK0JCDdbWERXp9myYt8dtbYH/92w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JS9kkHJUzhaJNL4JYp9piWeFTnAyS8VI8jbk0HF1bJD2AlS6ruDWQ4suuo9Re6cHrOqS6sOoKT1jjeEUZW1tJ670zTnh8GYFIIpYiaF/zFIsCT2ybZlaFQVIB15vCZ66+2NpETbZ/EA+eby++7I9mhH2+AE10K3XJl74BHpt0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0FlPk3i; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1c1f4bbf5so1245059b6e.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717162911; x=1717767711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hznZ5TbLrFJQo5daq/KQlDUyDPfA/APADPjZvBKy4Tg=;
        b=l0FlPk3iZ7n6uIW3+7GRMDHXVsEEpHT3u5VZ79erLfQ6pIYEkzbcwdPmZX+eN+UlR/
         flmoLNK2VXErxbF9hau98UmiaM/KP293lFjQj3o3UEGR8CiM4mQ6XuS1BxWZvg/LZrCN
         fXb4byBGl2ayCgJoacodRgvLDlfpRxDbuQ1dLkCF34/5JeWQG0HVvo1DXSRVNdtlA0NY
         Wp056qjZxoNEIyTZTtGfDq2SU0NSPTPLTAYf1/WYvzjh0UpKM4vDX45NhZpOcPiW4gKO
         bpnN2jlvadaZwHRw85ly/C3kuq5v9uehIHB0lAFmruArTNjSi+4LCNEq5tnLtqmxAknF
         qirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162911; x=1717767711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hznZ5TbLrFJQo5daq/KQlDUyDPfA/APADPjZvBKy4Tg=;
        b=WSYqPJonlxrm5fXazf+VfUBykGrJcySPRNRJCFQ2kz/KD4NXplCmQhd6l312E4P6SZ
         kAmUi+3AO+DMXAu1sAAOH61Bvk6GcerwzBBqfmbRg1T38uP4bD0FKlLhZXWLCKwwsQQ6
         wV0hOMMsiAjOdnTc2Anx48p4PRIiZGxo1TTVX3eN19rMziAsvoEMac4sjicvjQm0HsCT
         Rjidzh8LP4zWbc/uz1n0swsh33fb0V1dDdPAz8QOYnRMRTiJgaVR7DM5QLhXbDp1THOv
         8uB3S40WAThkZr3O3R6bdQJueCWMqCq/br8yr7qmpWqAVUs4WjOxpdwtAzSRFDvjyK03
         ysbA==
X-Forwarded-Encrypted: i=1; AJvYcCW3CjDbKkanSBJCCuvftrT9c6gYIDbF4xmoPe3OvmOVnEkm3HPn8ALDtXcrO7u9Xov2ZXLRdljnN9P0RXT9/nHK9ys7SIzu
X-Gm-Message-State: AOJu0YxThvkpOKWL83qBdEIHSb0WoiYZYbHMAnoHxkP/wXoG76KGhq5/
	8rhGh/Ftvb+0VMoZrAXo4SxQSK2ZZuD4dsp6c/9SpsVuMvGEt3cL
X-Google-Smtp-Source: AGHT+IF8+YfatNLkjgeRdgJ6qQ71ZeOY5KuN5/EdOMg8nmL8aiDsWykx1m0XRsyhGyP3JVwi6xudTw==
X-Received: by 2002:aca:1701:0:b0:3d1:c187:15d5 with SMTP id 5614622812f47-3d1e348cc10mr1730381b6e.20.1717162911148;
        Fri, 31 May 2024 06:41:51 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b416c39sm6440166d6.105.2024.05.31.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:41:50 -0700 (PDT)
Date: Fri, 31 May 2024 09:41:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 edumazet@google.com, 
 pabeni@redhat.com
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6659d39e801f0_3f8cab29451@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530233616.85897-4-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/3] net: skb: add compatibility warnings to
 skb_shift()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> According to current semantics we should never try to shift data
> between skbs which differ on decrypted or pp_recycle status.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

