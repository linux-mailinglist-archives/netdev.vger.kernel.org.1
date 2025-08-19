Return-Path: <netdev+bounces-214976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057EB2C643
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87BD7AE539
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A8340D9D;
	Tue, 19 Aug 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMs87KV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321E202C2B;
	Tue, 19 Aug 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611721; cv=none; b=a0bGYf9q1Eg6xYYX63vZ2c+QdJFI7yoJwusDzSpQcS0tb44dOHAzwf5W3o/xoWP9CvykJuy4LAAN/zBSOSW26vWnEQoHgyZMl/xp18X+AcX1u/b8X98OcRIpNPG+zc8Gm7myosq2YDZhGi02xnVk6yA3ZIn8iGafmCiDui7cbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611721; c=relaxed/simple;
	bh=HdRgoNyvGlv0blslP7TgARjcvijjgp5g7JQE+Na0spY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h3SSIoTsWYdj66SqfANdIxjK+5hMiJzZ9V67zlu7dpUl+pzSzD69TMAoePRLSLMNVEu8LfI4U210EhAtSYxw0ckRkntNReMtdzbvZnld66kyR96GDMwZoXa+Z8+73+YBR2AjaK+BL1ST5ip5wu5yg7spRUl8V1Tne21ITf68B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMs87KV3; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b09bdcb73so4491849e0c.1;
        Tue, 19 Aug 2025 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755611718; x=1756216518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibd7GwOhmC3MqSWvL4AYobC3T4haQQLYmBDW9/hgay4=;
        b=mMs87KV3TP4INqbq4R5BeUYOYozp8JxM07lrYc3S0ewpnJrfuJ22FjLR7owgHC5mcL
         559hKoNUM09DyueRCHDqYzOk61GACnog9TkhC6u1HVlWOiSi+lguHUDIRSWHf/PBwEGz
         fE04zp1rzSNauyfA2Ybw060eAFE77U5BP87WBUEjMQhZIpDGYyjsTwXFK/asz4lNg1l4
         MvJWVc3xkD8ZdQbCYEGJ1hxn6CzIwUete+2/RfZ+v2a3U571Nf8FGh1L9N+sVrxMlHxa
         6OeUGYNc6inzB7uXziFU5WIrVgY9ZtjNUtkAQzsf7QCH/I3iLhPTZLZoJZSsosNiLpzy
         abDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611718; x=1756216518;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ibd7GwOhmC3MqSWvL4AYobC3T4haQQLYmBDW9/hgay4=;
        b=t2QsssO+wK1fdjqMVkV/sH+AkHHcFyqEHflThmf9asyXTyZgZFxuoNB/3/8ULy7T0R
         /ManBu05gpmZoqdf9YFWC1KWdmB/wX5JZRsF0LY8552TUsWZKeInl7Na36/ptutXFjxs
         XHT9tdkvIUwqOxGbICtz9P+ntccjtIw7tCJcOoGMEQyZrkBJD4gSR5UtpG1dy7BMKPjg
         pGI2X80qXc05LQhEVpPj07/1GYERK6tbK0VE5JEdLchhKpTOeL1rqdE5BPl8aqeBBxUI
         q6NYc0JRKLeI9xEFmHL/6Yo2JXx2GzlqQlai5iwMi+V67lcPTSPOKa4wziog6X85fYXk
         kqeg==
X-Forwarded-Encrypted: i=1; AJvYcCUx7JznA6Dvl98uKlx4EWD4dc5IxLmBcW46IDBKdm2gGfNBFz3f2efOU+YQX4QMalMFi2PZOCbAjbvGWzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GyUXxSm3nUFsRF8q5uI9ocvDJSYQ8O7GI84fI/4f9iPequcd
	sGxxHI64rGhoAwMSvbJOODuXEthbmjMrOl3mMezUr6+4RbRv8Srk9brEb1cRa5Zr
X-Gm-Gg: ASbGncsz80iI3MtUs7UGbcy72CcL4cHoBZtLJK//o/dXXUqcJCW2OzjIXNGG9NLen9B
	xxw9z9McmF6WSqtApo0fCJL/RJlLKRxsMKE0dxOnlhieyqKloBuEhGrVx4OTCdUhIdmJlpbQ54Q
	+jz0b6lfi04kKbz3kXbhyXEApu/hSorjJ1Us0C5GnER0DcYh+MZQutxDvhNzvABSGucZSqRgzMM
	fjWwrWHGzqUVYsoOf9O/4h6TRu6ip9fV8G9OBNuhgAEq3nl6uKBkxdE6lfreI7LRG8lTWlUGf7V
	oMVVnqnaFdKyaY68eEiZj7pZwLmcCPGY0LTs4DbZRSf2HoWeXqUAX4DR9IRsHzEYqvsEL3Hgb7W
	DAsiqzIsHwvW0n6zo2U+QcyFL2g+zzYXJLWzH3hiKME/6W5piFp04LYkRYVB1MoKsWv5Pfw==
X-Google-Smtp-Source: AGHT+IEInlesI2rId5cEDBNwOSdQ5etELqd29Gj1DEM0JHb4V91Xcr06kMXt+1nlG/E4q+syWDXUwg==
X-Received: by 2002:a05:6122:25fa:b0:539:237c:f95d with SMTP id 71dfb90a1353d-53b5de39980mr704555e0c.0.1755611717959;
        Tue, 19 Aug 2025 06:55:17 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bd5514csm2570233e0c.6.2025.08.19.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:55:16 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:55:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pengtao He <hept.hept.hept@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Michal Luczaj <mhal@rbox.co>, 
 Eric Biggers <ebiggers@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pengtao He <hept.hept.hept@gmail.com>
Message-ID: <willemdebruijn.kernel.1ccfaff4b5510@gmail.com>
In-Reply-To: <20250819021551.8361-1-hept.hept.hept@gmail.com>
References: <20250819021551.8361-1-hept.hept.hept@gmail.com>
Subject: Re: [PATCH net-next v5] net: avoid one loop iteration in
 __skb_splice_bits
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pengtao He wrote:
> If *len is equal to 0 at the beginning of __splice_segment
> it returns true directly. But when decreasing *len from
> a positive number to 0 in __splice_segment, it returns false.
> The __skb_splice_bits needs to call __splice_segment again.
> 
> Recheck *len if it changes, return true in time.
> Reduce unnecessary calls to __splice_segment.
> 
> Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

