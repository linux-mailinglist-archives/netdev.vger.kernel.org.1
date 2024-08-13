Return-Path: <netdev+bounces-117985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C59502AC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054171C21F41
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F852195B27;
	Tue, 13 Aug 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abm405H2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAEC194C73
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545787; cv=none; b=lvJY2Vss43pGnGsSCLeJIuDjmyOJ19vo+f0YrTk7xZKQ2EkWlwI2rHcQv+OAq3mHZwDjaFud2UwkGEiv+gZDBNPhGF009SmK+3UqymtuNkaH1IB7fnqv6ycx5ZfkuNUmEORQ84UO4+yrtxInB8CEd7w6Yo3iztNLjt2nbCMS8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545787; c=relaxed/simple;
	bh=zWp0o9xh28pyAM4p55ml5Y76UacX0NtQX7AzptO7Cbg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UQSFyyHXBNfw0w6kDRnBWVq8H4qNCNdpx1ApykAWHybA6XBg1YtlZd3seF9SN1slu+oJJPSZB8uk1RqrDxwIv3WngAoYCXe2vSB44mQTyKjNa+Cfuxelh7KjnHoitCiL45X6KD8S+N52Be5PTLS/PdtULUnTpk8qsDWBUk/vRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abm405H2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so1897670a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723545784; x=1724150584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWp0o9xh28pyAM4p55ml5Y76UacX0NtQX7AzptO7Cbg=;
        b=abm405H26/S1dS06G5vl3AzdDT39QC+6TEqxDW3h82SuXQ9XixPaCCOfk6oE+/dz/w
         e4/puRB8irvdbW51qjBRQSoqHzUKL/aCIgQGVHfMIrdeMFKzmq83YaPPI4s00Xh7OwRb
         NPmrDvbFiE+LzTiwTOeAMO76Bywe4ZRCHaL8OAUJSv/ZGViVI3fI2lZZvpssblRRzFms
         zrAoORh90RAfaCrMoEGlTMzW3nAsH1h3UfF7AQ0Mkpk5yFWGIXHGENNld9MwvLpBU2lI
         Xv5xSFkZDDseQdrXeUmL6aBicIvMIgwq8iz9WfCo3sjSRV+Pq7qc7legsghHz0P1I76i
         VaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545784; x=1724150584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWp0o9xh28pyAM4p55ml5Y76UacX0NtQX7AzptO7Cbg=;
        b=uv/9ifkW0wDjutOLvAxfDAShSn8NjjF/14fgtcKsYs6Nb1c2fQUGkNI5TLxBwqDqbR
         RF/rAzL8n/IB3ykhBIYOt2M86y7SIJ6+VsurAVg7NwPWAyxpCAKuaJmGRCVhphFFM7QA
         Qs29C5L9RxJ3RIkM2UdDNMoLrmmp74A/Hnw0Z7K7PiFdyJh/7Kwp7SyoeVuJ0a2dhZP/
         X3R0o+QX++mN9zo/0SSFos17geQjcBZVQZjig4jRzF8Tu8T6S6+iJcWKKuoLJhIKGEzd
         vDJnAWv4ZpC/Z4XVkxldCea8uwvk07euGEcxZht0VACBGbkaCXbONmelxHhBCstwBwdz
         yuUg==
X-Forwarded-Encrypted: i=1; AJvYcCXOhbCr/hi0y2RhQyqR1WboqIqckkpqIfsfJkGSssamLYIAOniyGb8Wp+/mS/hDrgb2HRnZimexUwqGlR3cJaGeMl6FQ8hG
X-Gm-Message-State: AOJu0YxXQPVaQdkdML9enP+sUP3I3z2iezZZuwBHLdWdzTUfAppOC0SK
	leELZcvyW8aFNaZe5e/PHErO633he51I+gTeQ2Pur/9FvQVnDNG91N3zTYcTLcIazPHQUDlrUmM
	OH4JhpInfSfg9od5MWrdbc4EQlF8=
X-Google-Smtp-Source: AGHT+IGkkJ7fTEkr0h/dm3ZYVk5Cl4/rdCTWZU0aaBrCV5Ttw9VKa5ZJbNbwyTwQalXJPH0MxiJBMan58aDqq5SkI9g=
X-Received: by 2002:a05:6402:1ed5:b0:59f:9f59:b034 with SMTP id
 4fb4d7f45d1cf-5bd461c5d8emr2090303a12.13.1723545783767; Tue, 13 Aug 2024
 03:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 13 Aug 2024 19:42:51 +0900
Message-ID: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
Subject: Question about TPA/HDS feature of bnxt_en
To: Michael Chan <michael.chan@broadcom.com>, David Wei <dw@davidwei.uk>, 
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Mina Almasry <almasrymina@google.com>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,
I'm currently testing the device memory TCP feature with the bnxt_en
driver because Broadcom NICs support TPA/HDS, which is a mandatory
feature for the devmem TCP.
But it doesn't work for short-sized packets(under 300?)
So, the devmem TCP stops or errors out if it receives non-header-splitted skb.

I hope the bnxt_en driver or firmware has options that force TPA to
work for short-sized packets.
So, Can I get any condition information on TPA?

Thanks a lot!
Taehee Yoo

