Return-Path: <netdev+bounces-69694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5EE84C2F1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A8A2890A4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA660F9C3;
	Wed,  7 Feb 2024 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oB0uFWL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B313AC5
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275619; cv=none; b=BJFe9TojRjY9tVNqYA8HOoi15746+ZQyiozj8lCKoVMQL+RLKlqm786ekAgb5N/0wZ+AqJf4YKOSkzYAH8Pt/a+hPcfHvRUSvQNOKet1ugcbWQWOeF9CYsoi4Q6QVEx1wnjXrT3zuzdpi/wIKpQqgLgZIPISPMR+D5pjru10F5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275619; c=relaxed/simple;
	bh=UVIZMUqZApnFq5TzTa4FG3MxgaWrzN0Vukea5K2SS58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp7xij5nuNA1PHWafTcQRmMt+PWuoVyiiP3EB3tOQis/XsjPnO3Prn++WCEDTtH1MfTNjXJWzDbj0a53glov5SHy6+Ygg9K9rao4ouCe2Fazwz62S6rI8QUYa9tK74HmjLgDASN5zvkoPK12LHLVFe0ZBo0GNF7FZU9KmM7WONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oB0uFWL+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-296a5863237so1021829a91.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 19:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707275617; x=1707880417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCaUjOZhJAr8r8zFXeJysft5BO8ArZ3grS/f1fO/T/w=;
        b=oB0uFWL+j2qaRtUU8GsnWPHQuvQKWavFuc95kTnBJv8tnZzU+bi1Rpkdx8xgBLtvFb
         yTT54zoVOHYUBosaI3bxa6cN+wY4eA6uYemqn4pSLIJBGIFO6bGedVRAOTOu3xAblZis
         AiQL+xIsSBgkqpr8RxI/P+JTmJs4/OSjFK6MepcTXbFxokfJT5fX10rAtUf7vGHrBoS4
         LZUW4A3lOg05BSUAEqD2Vf7qMdRPPasRsybnE3LjrROl8JsYPVY4MgahC74bSEL83OL2
         RI6+jrLE39OeFKHbCURojMnqrLQUK/NsLS32vDSi2lXPJfT+PrIx5UBzz9PmUQfJX0rz
         hh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275617; x=1707880417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCaUjOZhJAr8r8zFXeJysft5BO8ArZ3grS/f1fO/T/w=;
        b=PAjxLnWPHgKmRVuEkI+bYTSuJ9GxLapx6Hl/hmid+ZC0Hg9gDWOJpCxm51YBYraIBR
         moWWHW4+CqNbSNmZw1nchYd57DRG0wzpO5zBzINjlXY66PdgY5IhuSERkZm+aZd0q/UM
         ICx5hpkvVRtv8upcteaUS0Ucgy/ViCUAnmZcApX7MAWvfDOl38HgFFtUvEjr/QIoU6AQ
         J3wfEfnJPwCg0pzGjHfNQm8O0PbRLtHYt8lED6szMDG3jO4+4s0wCYwNn3xvt/0Y9G2G
         YNqwUEvdht4tzfcBhe69xoQtYHoGiudT6C4+UuG5rZ6uwZczwY1j/bSglq5cPPNg/zEL
         PxsA==
X-Gm-Message-State: AOJu0YzzkX0JaSK4Cjz8KQo0goorl69J5sy4PfAoc5zNaZ9Z1rYvv/PJ
	imEJCceHIRZ6HOkyYQLeYLcyfIKwEXACfzMV4rkiuLWpGdFoZWktWE1UAYi8UGc=
X-Google-Smtp-Source: AGHT+IHUVL2zQA/dGs1l/mEQXgZ6DgMaZ0XurR3bZOavoqhbfOcNuNY2rII1N+5HUAiDJOx7w+S4MA==
X-Received: by 2002:a17:90b:4b50:b0:296:a68b:d2e1 with SMTP id mi16-20020a17090b4b5000b00296a68bd2e1mr2063943pjb.15.1707275617070;
        Tue, 06 Feb 2024 19:13:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw3iniWVcIoR8k/vsxFIeINwrBML5Aw/umnE+qVMX9w4JmWyd+airpuUW8x4bH3jSEeIzKwZhacTftJKNNKeoZ4Zf5c6ziPjSzlw+ezN54Tz1kPY0El5ZGjQ==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ft10-20020a17090b0f8a00b002961a383303sm2563769pjb.14.2024.02.06.19.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:13:36 -0800 (PST)
Date: Tue, 6 Feb 2024 19:13:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@gmail.com>
Cc: Denis Kirjanov <kirjanov@gmail.com>, netdev@vger.kernel.org, Denis
 Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Message-ID: <20240206191335.27e2b869@hermes.local>
In-Reply-To: <fa61cd41-a0ec-4b01-aa2e-577a1b15cef3@gmail.com>
References: <20240202093527.38376-1-dkirjanov@suse.de>
	<fa61cd41-a0ec-4b01-aa2e-577a1b15cef3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 18:05:52 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 2/2/24 2:35 AM, Denis Kirjanov wrote:
> > @@ -893,7 +893,7 @@ int main(int argc, char *argv[])
> >  
> >  	sun.sun_family = AF_UNIX;
> >  	sun.sun_path[0] = 0;
> > -	sprintf(sun.sun_path+1, "ifstat%d", getuid());
> > +	snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());  
> 
> sizeof(sun.sun_path) - 1 since the start is +1?
> 
> and that is an odd path. Stephen do you know the origin of
> "\0ifstat<uid>" for the path?


Yes that is abstract unix domain socket address.
Which avoids many issues with filesystem based Unix domain sockets.

