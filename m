Return-Path: <netdev+bounces-242108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34893C8C660
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0F0A4E1512
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340A19CD1D;
	Thu, 27 Nov 2025 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZt5mN2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21912B94
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201686; cv=none; b=GQvubFJNzVLC4rUAMIU8EReIpsD58zFQng1Am0pT4ED+UoRbdZF7rQgUjtRRH+vXFyvl6y3Y2FybC+k1Qls05ukJnfBi7BandzPK6+pYsBzTGOEdS/jk9kJXoo1DiU/j9blwtysrBdB96Kk0rYRfe1gaSCuGLgyLNfh/iwbn3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201686; c=relaxed/simple;
	bh=qtu1nb2Krxpt4zEcBrO4lg25dacbILv1IGv5eZFGv08=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dMMw17Cyi8osi8w2d0ujYQsO4F1tkb3Z2/GVgC68W/F+OpK1fjqW45uLgmvbiSWm9nNT/QFf9Q2HUJxX5bOX926TkygN2sk5gjJ83Uv3Sm2FXDZkJgODy1BShtEnftwUXPkNGIbmGBvZv5dBUcEkxdai24mH2vHVIpmyJdzJ9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZt5mN2E; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64308342458so308040d50.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764201684; x=1764806484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVT/rFi5k1cz1OWOuO76TzsQ6NfdN9/fjnD9KoCNbVI=;
        b=AZt5mN2EpGAfYw79MzXpTkuvXkIPDW2vbVpP+aitpSM3nGF0uC9rIfe+2X85Dk0VQ5
         ft/wZ3DsYyQchqY5R/4+JFU7LHkU7ekuDxgQ8wTlDSFYFfkC8vmAS0kPt+nAFw/mRzLj
         NRBoIDi8s0IeN7JaugJwpWEzK92NeJ+YycM9Xclec3bR9Yv2vzPB8yZxFDkXge2+k5kj
         yrfubMJeCOY/0KXLNYRK1bslzF9PULphiyur96H6qLma8xwZDWVntKbJsAZ+Ft1M/cMT
         sV4Lhuso6uD/SYPiftisfV6IXBbUTlqUqAD3D491Vz8Nj5XDfnnKRy7+jGkn5lC4HZg4
         1Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764201684; x=1764806484;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVT/rFi5k1cz1OWOuO76TzsQ6NfdN9/fjnD9KoCNbVI=;
        b=q3Z4sZ83xvRUlti77kaK7ZHFUkiKfVfBrTNtUR5wFg/tkvPEt/ZzUb6ZD1/4lr8Jxb
         /AVdWCO6rlwXjjioLtMx11uShDkwt+YbxeIo92Iuh6tPuZuFQgc3tH2ST7zKzo//0qAn
         pT4juSHFcLivDdcXoouWpMxZaCbdK3LD70kCna+vl2lRpw2a3UXLqI9pYiMaRu5t54br
         EjhJsIc/z9CW7sB+w4jWu/sBkZQvOnoBYx0ptS1FZD1gAT/+KDn/fhk8hj6mZIG8xqSt
         o9wiP4+8ry/3YghyybOLJSZyBdGWiVc70SA4DgUW5gfHslB/gO1evtFJT9Oo+9nlhGrB
         CXTw==
X-Gm-Message-State: AOJu0Yy03Y/6spWTKkyV83CjMp03YIr58HCAK5T2xoctt1DAxWU/Kluk
	+6kShiMZ7v866XbzkzmBMggZTlRPbU6u5Z+7O2wcFSUhUViGeTfPXkll
X-Gm-Gg: ASbGncvHtYbO823JghosLqHAvzcVgI10Rvd0NwkPwekzUxr5YwJNPAWzV3c8sK8k+Sr
	szKYduDM0dPPlIyNDX7UBw4ypjzIl2smT1qkWTPkKVXc5r2oKpd7ANxSWNf12JbKJunQRZ63s9N
	ZWE406tUCH5q8CeFDZRsq4mEvAoCascjGQttzAH2T7kbzaZzFJPM228kXcBuE3xedlnXiGRnfTx
	EqbuG6iDwsRnnCL3OygnlNXLP+f5jnxlfRAu72uhT8Q+FP55YlZ6YU5o5ZaUVpGkjuzmBY38Dr4
	k/zpaY3f8SzM97ezViJK16/nYoNrJaXFYIn99wJuvfXmk4QBWXNOMS3wriMWtRQjmX+2oBVDtJi
	dFPGzZeBXvZFtDxK9nteuBP3yQK0lyyrKT/e9O/vBzGKGB9zUBf2WNO/6A2djaMvX8ui1qyOjhF
	PrL/rBu9BQp52S+7B/mhmgonxHZeSYAjNEb4v7zKPCrwA6m/MLRcBShxmJ/1ZJeifpl+I=
X-Google-Smtp-Source: AGHT+IEcIuDSkM93TaEpjT+Lj3ojXyq6Cmhov4hMW/enDCWCx6CMSQZykaizGFHGM60nqXFzYcngEg==
X-Received: by 2002:a05:690c:6885:b0:788:1adf:fa6c with SMTP id 00721157ae682-78a8b5284f7mr179101657b3.33.1764201683867;
        Wed, 26 Nov 2025 16:01:23 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a82a0sm71622947b3.17.2025.11.26.16.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 16:01:23 -0800 (PST)
Date: Wed, 26 Nov 2025 19:01:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Message-ID: <willemdebruijn.kernel.2349231b3c41@gmail.com>
In-Reply-To: <20251125165302.20079-1-ankitkhushwaha.linux@gmail.com>
References: <20251125165302.20079-1-ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH net-next v2] selftests/net: initialize char variable to
 null
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ankit Khushwaha wrote:
> char variable in 'so_txtime.c' & 'txtimestamp.c' were left uninitilized
> when switch default case taken. which raises following warning.
> 
> 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> initializing these variables to NULL to fix this.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

minor typo in the first sentence, and there is somewhat interesting
context in the v1. But no need to respin just for that.

> ---
> changelog:
> v2:
> change patch name to net-next.
> 
> v1:
> https://lore.kernel.org/all/20251124161324.16901-1-ankitkhushwaha.linux@gmail.com/
> ---
>  tools/testing/selftests/net/so_txtime.c   | 2 +-
>  tools/testing/selftests/net/txtimestamp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
> index 8457b7ccbc09..b76df1efc2ef 100644
> --- a/tools/testing/selftests/net/so_txtime.c
> +++ b/tools/testing/selftests/net/so_txtime.c
> @@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
>  	msg.msg_controllen = sizeof(control);
> 
>  	while (1) {
> -		const char *reason;
> +		const char *reason = NULL;
> 
>  		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
>  		if (ret == -1 && errno == EAGAIN)
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index dae91eb97d69..bcc14688661d 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -217,7 +217,7 @@ static void print_timestamp_usr(void)
>  static void print_timestamp(struct scm_timestamping *tss, int tstype,
>  			    int tskey, int payload_len)
>  {
> -	const char *tsname;
> +	const char *tsname = NULL;
> 
>  	validate_key(tskey, tstype);
> 
> --
> 2.52.0
> 



