Return-Path: <netdev+bounces-75973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1486BD00
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDFB21225
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A481CD1D;
	Thu, 29 Feb 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dEUJTIrV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAA168B8
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167898; cv=none; b=JUuxyJs/OqjzHdYsxcTpYUbBqtOs1rT5lDU4AlU6axzb/6Ye2J+UZIEAL3OwS7a2eWQKCyxlgEAgCbVJls00zhHxZijVAnz+SyoGeKOKM5yJPYID+JUHBhhtxoqW6Mdv9JUpASLIJQjNaJP7uwt5mRnvmBVsb5hsCGooWNGRNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167898; c=relaxed/simple;
	bh=Bz11S427KV8OQXIjCiAYtH+xSVq9pPusgdXYYcqYA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0X+etVV3vYlCEzoa3uGKPKUwboy5Koe2hu7Thy6GrsvunQfGylw3/cLZhkXafV4bN/pEVg9X9gQzm+BI98pxPdoruXYc2FH4WCBUttQJypAd+1Mw4d8po8gcUPtbrhOSiXUxQDi+wUaoLHbCKzXrOkroK3wOFE/Nv8ytHdjbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dEUJTIrV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7232dcb3eso3200915ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709167895; x=1709772695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAd88Uqkqrp+Ux3HCv2HmfosJELXuOOEhRfcuHOPURQ=;
        b=dEUJTIrV4OEQ+w+4etiT3cM6Ollb6nZG6DkoyXbWLTT02V5DHvvO8+G18FWWC9Pqr0
         OVaIEOantoWcLf0CvACH9wD/7+XA2QLJ/nwOcItOYABt49SyO1dK5OYzMwRGumnk/7A9
         24w9f4yaTJ7YOhq/h7HkaYS/8P8NQ3HGMt19wpyybzfiVMk0WCpURnyPa6HkfNOKbC44
         8lSZYn0MnieDlOJw8kj83Ll9+rqZFHUKNgAuztp3qvh/T7fuWEmbIrYnkCZmcpywH4CV
         oV2akBvAN/ptMDBDqIeOW3EUQ0YviX1uch9lG829WCo6g3VlO1oUlar1kJIdfPFg4x/t
         Ck6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167895; x=1709772695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAd88Uqkqrp+Ux3HCv2HmfosJELXuOOEhRfcuHOPURQ=;
        b=DbJ0U76KvPFXu4AqTjv2EaX+34HkQwmt8Nk05Ur6xrJbp0A4rGfGheNXWG199RmmIQ
         9od9/6IMXMP2w3oh2nIlIWpYy8QoBDxXGKG5OeP5djr6d7Ea/IplSZrTWFdrD7UU+2I5
         Frwxz6qQ9nCRyz5BbLbIdyjgX9gjov+5liO9owyWVjGmcZcgukYGnFp7w+uwniPmzPiz
         K+ZvTB+K/qc8dOvIg7XJxZG8bgfZJnWu9HHLO1mVSPHQh5c/lphqdYCQseOktnCk5+GW
         OOcoKUL53HmU0Klpy4eN0k1rh8y5ERKAj9VgvsktZU2cz9JiGAHjd/UlI1KWOtZdvjhH
         RDTQ==
X-Gm-Message-State: AOJu0Yxfy21oaFpSFAPQLpj3GJkQJzg6bC80JO3nIDQQXFRVCxxkcBOg
	KnT6MAuYK9bLKaWKN14Dl1gW+j4hYY3BpmvJTNLbW07sToId7lZtEj0maxoQ590=
X-Google-Smtp-Source: AGHT+IEnrYFo/GL0NYh1lluoXzSEw1lXYMUJgyqfDNvK1NUn4gaQ0aukPlrefkOeyKW+ZFdI84iFZw==
X-Received: by 2002:a17:903:2c8:b0:1dc:adda:6d45 with SMTP id s8-20020a17090302c800b001dcadda6d45mr813972plk.18.1709167895575;
        Wed, 28 Feb 2024 16:51:35 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001dcc18e1c10sm70371plh.174.2024.02.28.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:51:35 -0800 (PST)
Date: Wed, 28 Feb 2024 16:51:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2] ifstat: handle unlink return value
Message-ID: <20240228165133.1799deab@hermes.local>
In-Reply-To: <20240221120424.3221-1-dkirjanov@suse.de>
References: <20240221120424.3221-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 07:04:24 -0500
Denis Kirjanov <kirjanov@gmail.com> wrote:

> Print an error message if we can't remove the history file
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---

Good idea, but would like the output and result to look like
the other errors in ifstat about history file. Something like:

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 767cedd4aa47..72901097e6c2 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -937,8 +937,10 @@ int main(int argc, char *argv[])
                                 "%s/.%s_ifstat.u%d", P_tmpdir, stats_type,
                                 getuid());
 
-       if (reset_history)
-               unlink(hist_name);
+       if (reset_history && unlink(hist_name) < 0) {
+               perror("ifstat: unlink history file");
+               exit(-1);
+       }
 
        if (!ignore_history || !no_update) {
                struct stat stb;

