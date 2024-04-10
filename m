Return-Path: <netdev+bounces-86468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3480B89EE99
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A4D1C22052
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32714B082;
	Wed, 10 Apr 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTy9amy4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A413D2BC
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740457; cv=none; b=ZbRr172N5rY6cR/B7mB/4simPZzExqjCBiVLahltoh/co52HSRwg7H1k/P/vY70dzRWxLeXbPKKhtr/FOL6Vl28O6aec1nmD8HpUNgL9FqTAJt4C8eej52PKedU853seYdOEw3fmQcW1mo8FiM9rZixTycwxhcTSe04zj7a2WQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740457; c=relaxed/simple;
	bh=xHUU3euj9nf8zWXAyIqM8Df//lN36cK2YcLBEnDjmwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=at8pWecPfyL7EPkImJDtiE93XDqo0iw5rz8LsGOslIsoNtc+VSuiD+fj87p7uJpqco4/PDNPBVEXaTyDjxXuf5nI4yUegkmIrwH8LpbqlpNmbkytg4zxgbhMzEFhFG262eNadGgZ+LxST3vbPP9QzNCce/+G2wyab3f2l8hN680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTy9amy4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712740454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xHUU3euj9nf8zWXAyIqM8Df//lN36cK2YcLBEnDjmwk=;
	b=dTy9amy4WUIIzPZpaeklu/st+eWTadkROzA1rah/BcUmy6aasktCzijBs9edncpZy72fr3
	8UfSpbtoCx1CO2JI/xCD0YtxmvfUyhkJ32y/BtB7FEa0H8dRfEgfjVNhtNYwLmATogNr5v
	h+aVtz9EbdKu+/prpldRjEMWJA/Clqc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-We3V3XQ2PESiS4A02v--HQ-1; Wed, 10 Apr 2024 05:14:13 -0400
X-MC-Unique: We3V3XQ2PESiS4A02v--HQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3450bcc1482so1127038f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 02:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740452; x=1713345252;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHUU3euj9nf8zWXAyIqM8Df//lN36cK2YcLBEnDjmwk=;
        b=d34/BdoCuwLxMadtvSsSqG21UPKM6Lv3CLG7A8KnucCVrLoMBYZWgq3W2BLecFcvUD
         LpFpKq+egZ/KWzchzuk9z67VTvsJieqDaYg38gkGuC+5q4AykZU1xWPXjyPsQepEe5+Q
         FRWleFpCsjRRzxSQii9eoRZaLlZ/+3NzIYDLVat2dytyhHkrhUpbcMNcMqlyCbiOX4x1
         bU+PxMHg8nPpktnp46jJg5iZkqROsKqfoNOXZman07OQz7OVuLh5oQm0Rr73CuNoBy1M
         lIT4hvrzyjJv7jnQL30tjORf1vnENFJBb2onow66n8FCkvhCN0P5W1TvFmuwYTxvJwi6
         NAUg==
X-Forwarded-Encrypted: i=1; AJvYcCWEsX5TYZjoQV64w2bpWiFEzHQLoreQ7jFBVXLfpKLFVxLxvREzd4DnDAMRwauzl5pi4vpIwvhtIQ/i4oNHqVW2ExYN4yOz
X-Gm-Message-State: AOJu0YyrZyskHcobVQqDAdfQFU7IkbYf/hkNtfHteAYQ+co/j+QwkBdO
	1YLshO8ePy0jTwCehojd0X6WJQoOo6v5ap/bgm8an1uO4N3N6G6s+4oVMQGD4eSvrO4wzE/Hlct
	KDUvt0R0Fs9qs39A7SuTygHrORIaf/lAdoQskDCYX0cSL8hLgMc8Zhw==
X-Received: by 2002:a5d:5982:0:b0:343:b9e4:ac2a with SMTP id n2-20020a5d5982000000b00343b9e4ac2amr1638957wri.4.1712740451890;
        Wed, 10 Apr 2024 02:14:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc3DZgvTytf13rNBGQ+nK/JTUXqG0szZTwLtJfnPacsQDDLImNcG23oNQyHTcJGrdsma+Uxg==
X-Received: by 2002:a5d:5982:0:b0:343:b9e4:ac2a with SMTP id n2-20020a5d5982000000b00343b9e4ac2amr1638940wri.4.1712740451569;
        Wed, 10 Apr 2024 02:14:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-180.dyn.eolo.it. [146.241.233.180])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b003455e5d2569sm9785033wrr.0.2024.04.10.02.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:14:11 -0700 (PDT)
Message-ID: <09f0fc793f5fe808341e034dadc958dbfe21be8c.camel@redhat.com>
Subject: Re: Some questions Re: [PATCH net] net: dsa: fix panic when DSA
 master device unbinds on shutdown
From: Paolo Abeni <pabeni@redhat.com>
To: xu <xu.xin.sc@gmail.com>, gregkh@linuxfoundation.org
Cc: vladimir.oltean@nxp.com, LinoSanfilippo@gmx.de, andrew@lunn.ch, 
 daniel.klauer@gin.de, davem@davemloft.net, f.fainelli@gmail.com,
 kuba@kernel.org,  netdev@vger.kernel.org, olteanv@gmail.com,
 rafael.richter@gin.de,  vivien.didelot@gmail.com, xu.xin16@zte.com.cn
Date: Wed, 10 Apr 2024 11:14:09 +0200
In-Reply-To: <20240410090644.130032-1-xu.xin16@zte.com.cn>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
	 <20240410090644.130032-1-xu.xin16@zte.com.cn>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 09:06 +0000, xu wrote:
> Hi! Excuse me, I'm wondering why this patch was not merged into the 5.15 =
stable branch.

Because it lacked the CC: stable tag?

You can still ask (or do) an explicit backport, please have a look at:

Documentation/process/stable-kernel-rules.rst

Cheers,

Paolo


