Return-Path: <netdev+bounces-100491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AB68FAE7D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0363828651B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEF142E9D;
	Tue,  4 Jun 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP11JSt1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02113A415
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492500; cv=none; b=DNIZH/yUfgUIp8Hjbw/d9je+he9Xehvv49sohcY4ZHqavt1HBxu7sczhT40FjvsZIGFaYa8XMj+bad6pWUI8FXjUzscT98Q9DPEQF3Yw+J2hdKOwwXDX/ynHxR1l19NaCex7zPh03N/CQrXRVe7/+IG1o68ShFT5lMRANXZgz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492500; c=relaxed/simple;
	bh=HrgTOcnqhV0jwjo3t+kwC4zZG4Yfcv3dICMSxkUAf8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fcn6J5uJXyTtr/3YjSXXO8O9pGT7kkAuVoMdNDdMiK9M3JPrnHDDeLKmBc0jXKuBURI1RFA+1szSHh3ybtaNjBRgRwvOeC4e8fnYEccpYlVMLsCkTiilHDPJHKEV+siqnBPSyMIDfWnwoVTZlH01JTMjfCJiiCzIDUrRvqn8MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OP11JSt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717492497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HrgTOcnqhV0jwjo3t+kwC4zZG4Yfcv3dICMSxkUAf8o=;
	b=OP11JSt1AgkHmyaLxudnoZkXEVlPhoI3PntcC/OACN8jNoqWo8yhlDl7FVrzdsX0k/gedY
	aA+wMAjv6L1DDtG5LwC/V2L3Q8P4OZRWaaR9nOj63g3Hx62lk3ExEqNqKMR7e/VNsKxlxP
	2xVwhII+dUHWS1bEUkMAiE6z+QNfXfI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-zUQXQUlVPh2twgyn6zp9hA-1; Tue, 04 Jun 2024 05:14:50 -0400
X-MC-Unique: zUQXQUlVPh2twgyn6zp9hA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcec8b776so194595f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 02:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492490; x=1718097290;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrgTOcnqhV0jwjo3t+kwC4zZG4Yfcv3dICMSxkUAf8o=;
        b=sKYMOO7t6KRGt64xrieh1uoofu4UL+/OOVB0esu32TMkxnTiJQEJVHwg7Vy2/h/6/r
         DU9JFfCF8C84RXQEMLfpBX5kVjCHbrq0AUXFt+a3GjH5EzLG+OFRHLUouSx97iGTAmUX
         mygChW02nxNmgnxQFCxAu6/114jfl7TtVN1SFBkk/tA/0mZbVgdGcAR+fd5I2tpMDCdc
         p1pcABkt9LOJOdqb6eDUt+paFUIr1giIo7wLdC5GEt0IUpl1j548Momxqs/tArT8Obst
         07Iv/DMCbbe+YEc2rcBWeQgfPS3bwD/BIS6mkdeaDjVGmREGaMVY7Kf2gykUHIVpq0BC
         U9rg==
X-Gm-Message-State: AOJu0YwYQ8fwWlkRquu8hwRiEPahYAI1JpqhzMgVBhqkDZBE6MgTqFbn
	A2XjJeCp7OZO+rKkpuykWBboZBkmwplc7Hf3rJjkTEZuBk84hGifIk34bjdDTQ/LrTtwvfkCEEL
	RVoiBV4BN/CNecL2+exULgWcPf4+ClAu0NI0LgPMc0e3DId1z9poF+w==
X-Received: by 2002:a05:6000:400a:b0:35e:51cf:6908 with SMTP id ffacd0b85a97d-35e51cf6a65mr6163587f8f.0.1717492489886;
        Tue, 04 Jun 2024 02:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB5c5Ma++piB44Nc4XUDMJlsIgzzOOAxkukz3ZPI/tAonULa9pV6Z/i3heUntj49i4nCRvJg==
X-Received: by 2002:a05:6000:400a:b0:35e:51cf:6908 with SMTP id ffacd0b85a97d-35e51cf6a65mr6163573f8f.0.1717492489559;
        Tue, 04 Jun 2024 02:14:49 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064dfc6sm10881201f8f.92.2024.06.04.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:14:49 -0700 (PDT)
Message-ID: <d6a905fe4d51f4f4ea42bb19d890aa5f621d8e9c.camel@redhat.com>
Subject: Re: [PATCH net-next] seg6: fix parameter passing when calling
 NF_HOOK() in End.DX4 and End.DX6 behaviors
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>
Cc: netdev <netdev@vger.kernel.org>, contact@proelbtn.com, David Ahern
	 <dsahern@kernel.org>
Date: Tue, 04 Jun 2024 11:14:47 +0200
In-Reply-To: <4545d7af-3cea-4411-83ee-c6eb5696b15f@163.com>
References: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
	 <Zl4YGQ3pqEobNTAl@calendula> <4545d7af-3cea-4411-83ee-c6eb5696b15f@163.com>
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

On Tue, 2024-06-04 at 14:34 +0800, Jianguo Wu wrote:
> Hi, Pablo
>=20
> On 2024/6/4 3:23, Pablo Neira Ayuso wrote:
> > Hi,
> >=20
> > On Thu, May 30, 2024 at 03:43:38PM +0800, Jianguo Wu wrote:
> > > From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > >=20
> > > input_action_end_dx4() and input_action_end_dx6() call NF_HOOK() for =
PREROUTING hook,
> > > for PREROUTING hook, we should passing a valid indev, and a NULL outd=
ev to NF_HOOK(),
> > > otherwise may trigger a NULL pointer dereference, as below:
> >=20
> > Could you also add a selftest to improve coverage of this infrastructur=
e?
> >=20
>=20
> Sure, I will add a selftest to cover this case.

When re-submitting, please additionally target the 'net' tree,
replacing the 'net-next' prefix with 'net',

Thanks!

Paolo


