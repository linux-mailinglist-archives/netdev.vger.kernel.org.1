Return-Path: <netdev+bounces-168233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDABA3E303
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C074A18958E9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4002139D2;
	Thu, 20 Feb 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VYRrk/fn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695A2B9AA
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073741; cv=none; b=XyEVlNc9YeKa6uSsGIaGzVP0v7/oF05nJ/8xsAJlib59ZsD6InxXHXiPfOb1CMQmY/5n1gMXK5gdShI4XBZ+H139SfgAZyspaKkr6gTZOwi236p9W1rwa+jHhG2VJ9QxqTyQ0uNeYvKrZTtMDnMU/SNViugpR0X7r6gOiIqp46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073741; c=relaxed/simple;
	bh=Njjn7mglB6x85ZHyod9b15fE8ygWv10+9BU4Hg66pGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8dXq/8KKog4S2SzKoX25Yg9AWY1znpvfA5F/AfDahTSKlxkOANZkNJ9jrevo8MOHMfKuaZ2gKeoDyf6clYXGIWYoMzrEIZ6j+K1MFTSNmKHEQ71qToyqf0+km/PVLN/ib6DdDTsXnxd9q+C92+RtfmSoLcvMQ02Ol4S3FD1W3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VYRrk/fn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e45dbf15c7so9178816d6.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740073738; x=1740678538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndoHQwkmFgDR5FgV3IZ/57KVk6Byan36SrDD2kBg894=;
        b=VYRrk/fnBZbmx5vWv9TWTEwcHMxYfZnhhrxyjlmEZvBBGMqxZPJ4zhmbgv1R2Hi+JT
         Knovv7MMFbvcfioDnRjOqR/iXVhfvUeCapl6S3OTX2KyOyeFJ9syG+dBcD0ErITEF2L6
         WAfTwJvdpyDBdfBpjbs7IbFNJFMvXn8OM36GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073738; x=1740678538;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndoHQwkmFgDR5FgV3IZ/57KVk6Byan36SrDD2kBg894=;
        b=HxRFulOFYBbqZ4fbLpn4Dcism7fyV3a/rKdWA5AOuaSTLrH0YHxg7Uw3ZUDIgbzGqP
         mxXzA4XwJmn3v/sTSuJbmHIiJkjom8j1Hssa9RzaXl1vmzA3KcEERawog4GAiqZxoxBB
         z7ddJIidSkBr6bCU1LxBtdg6N6x72NZtJE5lczyHg+lrQphxdfAgegG90oLIIp80fcA8
         CE0K3gHFVi/+LjEel/HYcYx+Q4irCITazgV2R44B3B3cBxudUc1SkaEtz0TKVrVwjdu2
         O1CSY2+/pWlcShSsXulsVkL4bk49w3XLY8gc1L9utn/DO9rZdPF5oPnxZ854wZwYuZZ3
         E42Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvwdNtPw2BN7LtIgrNCIzcSPrlvYl5822pNXwxpAmIBBaYwpI0CwADj5TuJtiUdqQSKCa3/aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9jmwnGkVL32PiVPvguNWnTjOEVHCkWMYgyr+/Jao1UeYr5h6
	i9UdkltaBTYrrrCrn6MmURUW+rdMvbqG+mAwTciGpffNf3Mi2bfkSvm3dMIgZCc=
X-Gm-Gg: ASbGncsftIzOjgBve4B4829/L0gPpREsHFwB5chm0xWKiwugXBrfvo4OYI6IU3HDKbG
	fz9PK0lR5tj4fUfKpB18dQg5RErUNNYnX2UTVFcFQAFYydInyiLsrMEdFuiQFqItV1i2hOmIFfI
	N0VPNdkm2wd9Eo5pIO4zVy2gdcDm8lnnptjUjsDBLb4pat0bMnsBsiECm0mqioRywqoeskWJVST
	Q3LX3MBRCtS3zRi+KzQEasLQWxYwxXS2Z8qzMOhF0WEjbGMiqOf0HUCOKTrZM+OL9D37KnyqtCT
	Wp3H2vdRcfIzUwuc2YoOkawzsbWNnwHbvceNFh7XVror2fzuo5rvCQ==
X-Google-Smtp-Source: AGHT+IHhGV4QKejlmXeC0SiEKZTouZiBngn6yS/0/1ouCKz8q1payQTpbnn7fnmPISPDyS5qgXxDqg==
X-Received: by 2002:ad4:4eaf:0:b0:6e4:3ddc:5d33 with SMTP id 6a1803df08f44-6e6ae8221d7mr345436d6.13.1740073738501;
        Thu, 20 Feb 2025 09:48:58 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3b64sm88400276d6.50.2025.02.20.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:48:58 -0800 (PST)
Date: Thu, 20 Feb 2025 12:48:56 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 3/7] selftests: drv-net: add missing new line
 in xdp_helper
Message-ID: <Z7drCEsGAQz6cxjf@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-4-kuba@kernel.org>

On Wed, Feb 19, 2025 at 03:49:52PM -0800, Jakub Kicinski wrote:
> Kurt and Joe report missing new line at the end of Usage.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: new
> ---
>  tools/testing/selftests/drivers/net/xdp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
> index cf06a88b830b..80f86c2fe1a5 100644
> --- a/tools/testing/selftests/drivers/net/xdp_helper.c
> +++ b/tools/testing/selftests/drivers/net/xdp_helper.c
> @@ -35,7 +35,7 @@ int main(int argc, char **argv)
>  	char byte;
>  
>  	if (argc != 3) {
> -		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
> +		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
>  		return 1;
>  	}

Reviewed-by: Joe Damato <jdamato@fastly.com>

