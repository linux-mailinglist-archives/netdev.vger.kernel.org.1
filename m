Return-Path: <netdev+bounces-107143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD291A167
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4648C1F236AC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E37D07D;
	Thu, 27 Jun 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chM9/C2V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795457C6C0
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476811; cv=none; b=UKnYzvKCzU71P/sqJG5aMz6rfFK5AwCiBr7DQNCx6jzptrf9oTny/e390exCegOAOu5rfrWBTcy3fc/4vqAHqTPYYP4zwhUTsDYwIDfDiqxke9LqiOEd9rQ4/L44INS5+7kk3KY+cjjLieOIz18n/Y9FwXvsG2CEfhaMeQqgS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476811; c=relaxed/simple;
	bh=MeRMQWE14N7cDDcCy+ILjDSI0eJNByPIQ0xzmqIzSpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvrAr46x7OGaLApIETMP+muvSWXfwDc15Nc2AmyDVa0KQ6UFCtHYP4nPunF22rWxfhsnKEI9kzIWXKTaJiLQUcjKH0vJokUnOhDc713VMM5od8VWNBGABCQqpOzblMmkNqhcovpF8HaUZERFwLOqceowVpPUhWH3vb4BqWxOxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chM9/C2V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719476808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hLctzHvwHXoWv61Yp7Sw3OaxGGrZTS8a7U3WcjKazis=;
	b=chM9/C2V66TQdIxM6/eaDjizfuYrSS+ZJdSEqIl/cSPb4JLvwnocPPnSVlPaJZx6oXl8eO
	lqSbtMlE4UzBoQFfr2ohW9qLbZWMjRR8g5LPhEpSV8qKGdQVWViaRvBi4BVZHByuQ1izYM
	Hwbr4r8OaRqXjRxDMaI/9hSW3KU3N+U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-3XEpNg3sM9OFZNUx0F81PQ-1; Thu, 27 Jun 2024 04:26:46 -0400
X-MC-Unique: 3XEpNg3sM9OFZNUx0F81PQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42566fb83c5so284195e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 01:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476805; x=1720081605;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLctzHvwHXoWv61Yp7Sw3OaxGGrZTS8a7U3WcjKazis=;
        b=qxgiZQ+wXyxb3MMR4v7UIAwzZQtkl923M3JYw/CGsU3f1jWAyLQwwekf+5bZP3tJZE
         plRqB4IQiBX1zcrhTBoXkqdCccNQnO/TptXifUSWGhkMolHR5t4ROSWbN98YY3AOJ0I/
         HoYY4fJQOBfwpFCMCkIaeVpWfebKBgiA2XcdiEWNF+nCTphQ185dIWYQXuaGMTcnfQdx
         zK4+sx+9Wl9UdT8g3ophItbQzyOlx2uISplXQDpanaC5s14JuXFZB11VHWzpNBeJlK8V
         S7ROMRbsIQ60yFQK0k8sG3Wh2fi/bCI+xQNW0ijCmHGRSz0H0tTnM4K1r4kP6OWWbWlQ
         VG1w==
X-Forwarded-Encrypted: i=1; AJvYcCWN4NeQ9RzVr/QlSBoI/3m5LtX2KU+dtOEe/RlSCLgixdlPdPwh9VGyGQnWJm5ycpvUaD9AklLOA42JdSRN+7DnoB0Oz5E4
X-Gm-Message-State: AOJu0YzOMmX4f32FSAmd2FLLKfpGUrhJjaTkCi1sEedCiPf+yJKsqEVJ
	nfUKV87AUUD7Glt9iLLjkTF1oT8Bk7XVqKr+TpMsBet12bkypYB8DnqdOwmEWyWNcFLojEJCvh+
	1zV6ggKCtVfHvT+4JxsI4aoBM8XuhEoUIIXYyutE/AFTKD4yIV7XkuQ==
X-Received: by 2002:a05:6000:2a7:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-366eb60beb4mr8714372f8f.3.1719476805472;
        Thu, 27 Jun 2024 01:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMK4mgcuwyBePIXLIOiqAmne7B4AxONsf6bh0FN4gAXvMnbT7GdVMQF3s/C+niBji7Arigng==
X-Received: by 2002:a05:6000:2a7:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-366eb60beb4mr8714357f8f.3.1719476805099;
        Thu, 27 Jun 2024 01:26:45 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2716:2d10:663:1c83:b66f:72fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369eb94sm1066005f8f.98.2024.06.27.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:26:43 -0700 (PDT)
Message-ID: <3b627586b19c232d24e135e8dcd9323063531171.camel@redhat.com>
Subject: Re: [PATCH] net/dcb: check for detached device before executing
 callbacks
From: Paolo Abeni <pabeni@redhat.com>
To: Denis Kirjanov <kirjanov@gmail.com>, netdev@vger.kernel.org
Cc: Denis Kirjanov <dkirjanov@suse.de>, Hannes Reinecke <hare@suse.de>
Date: Thu, 27 Jun 2024 10:26:41 +0200
In-Reply-To: <20240624134607.1701-1-dkirjanov@suse.de>
References: <20240624134607.1701-1-dkirjanov@suse.de>
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

Hi,

On Mon, 2024-06-24 at 09:46 -0400, Denis Kirjanov wrote:
> When a netdevice is detached there is no point in trying to execute
> the dcb callbacks; at best they will return stale information, and
> at worst crash the machine.
>=20
> Fixes: 2f90b8657ec94 ("ixgbe: this patch adds support for DCB to the kern=
el and ixgbe driver")
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>

The patch LGTM, but please fix the patch sender to match the patch
author to make checkpatch happy.

./scripts/checkpatch.pl --strict  --git HEAD^..

before the submission is your friend:)

Also please add the target tree ('net') in the subj prefix when you
will submit the next revision.

Thanks!

Paolo


