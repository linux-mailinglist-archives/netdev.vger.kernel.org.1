Return-Path: <netdev+bounces-122378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F45960E04
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564AC1F24257
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190A1C57BC;
	Tue, 27 Aug 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avC1W5fP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12D73466
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769842; cv=none; b=oj47/Oop7RDudd/izje+np7hXfoh/2YwWFTsatQi2WyFcWMRzmdp24JWT+LVJVF2+jyMjriV9aEchKCSVGPJ54/ES7vcsR/+U0MuVol7qfsKLr1oHOUWF22TAGx0YTGIoEAcMwhTwnQw/qNUHlmmxz36s7+rXLEDdr30anB7SVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769842; c=relaxed/simple;
	bh=oM2brBtGt+OphQ+ukuvC5IAHcPMIa5JteDm7eIPlEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD/W6Mx4OScpds/i/SoLgE7RBMCnejoTJhCDpfwldf0H19ctBJ5/M9yZBHFFhUkZzve5bn1ToYMFMq9HzD+to7vPoLZt7hvM6SAlCeHa9Gn4CyAdz+9JKeUVEveTCttDN+6fmhRTKiXpr+6Z38+B/ZxvLTsY9XCTa97TtuZURlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avC1W5fP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724769839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJBAd+Vbv/uzFpiXGoe8X70Z6GCJY3PwLwfnLtqWRa4=;
	b=avC1W5fP4FzFV0ETly4x53oZQimXg4fKX2YfQ7JmIOAEBjaBEZ2ck10SDPufQQdlrmYZ9Z
	n3jMlJIQXXnlChdtiNQ/12W7pWXq9e24h6cvb0f1ggenknpzqzrj+dWPbEMMvv9701gxw8
	x9kr6Pn53CQaNsCjesyp23OXX5oLfuI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-KUqftVMgNN-jCJof2W1a5w-1; Tue, 27 Aug 2024 10:43:58 -0400
X-MC-Unique: KUqftVMgNN-jCJof2W1a5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816aacabcso49283405e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769837; x=1725374637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJBAd+Vbv/uzFpiXGoe8X70Z6GCJY3PwLwfnLtqWRa4=;
        b=aMXo/EfBqytRGEJ3y2mj/GbKTCYXihxBem9bYqR6J9ntgztfoV939yr1lDpWlBvQtz
         h8xEX9jAAaddVt7Y66FFEbX+2yG7hLc60MghIdS8Ay0HuzHp6DVH16Q0JJS88Z2my2/J
         M+i4bi8r2b3hGDtwg8gM9m64olALQUnJXOKpF++EqGXOajjwZQ2wtruSCuN1/qtY5a6E
         ucuki3xIdUTDtHwg2Bjhwg+hCjN4J9QHX/7bpGRDkiPyhoTg/1ccuegv0WEQnUmpkhSj
         zwcO+HkY0nA2V7btE1eikkFJiWu/5DvWoK3OrnTYqpE2+zdrAsdRGB9gec6+t+iF1DXa
         jU/A==
X-Gm-Message-State: AOJu0Yz74R/h6XZJG6yIvswKkqq13TmY5biVY7PH85cocsRw3GuTKyGS
	VYy3+4pjUIeOYroHPM8WQlmkpUoQM82s4avI5sUOCLlFZeqNn6EI/5Mks5lo06tjXGEyIYL4Xkw
	AgBdv/SDcTgtBf8SXyTkNRVedkEDAC+4LGQXKPeoCImPKW6uTOnnOfJP1xSHoNg==
X-Received: by 2002:a05:6000:b88:b0:371:8af5:473d with SMTP id ffacd0b85a97d-37311840cb5mr8212457f8f.12.1724769836861;
        Tue, 27 Aug 2024 07:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVRRVuCCRt+5gQlt7iq7J/T6VTyjoxl5THgBfg7ATi95knELtLhdYqaWbZyCGmR1TU7wFeiA==
X-Received: by 2002:a05:6000:b88:b0:371:8af5:473d with SMTP id ffacd0b85a97d-37311840cb5mr8212432f8f.12.1724769836185;
        Tue, 27 Aug 2024 07:43:56 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514de6fsm192830515e9.9.2024.08.27.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:43:55 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:43:53 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: Unmask upper DSCP bits in
 get_rttos()
Message-ID: <Zs3mKW5twrchCk4g@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-6-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:06PM +0300, Ido Schimmel wrote:
> The function is used by a few socket types to retrieve the TOS value
> with which to perform the FIB lookup for packets sent through the socket
> (flowi4_tos). If a DS field was passed using the IP_TOS control message,
> then it is used. Otherwise the one specified via the IP_TOS socket
> option.
> 
> Unmask the upper DSCP bits so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


