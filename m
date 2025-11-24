Return-Path: <netdev+bounces-241242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A49FFC81F6E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08F984E709C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEA2C0F84;
	Mon, 24 Nov 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQcv2Wfs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073812C374B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006415; cv=none; b=f81x6jC55m5bDt+423GmKKY+jmknZHDk8fq57Lugp1jCnx26NOiWcU159u+c0tGdSaMHiXeI87/Dkb1HzaIQ+yZpokuBuOPzjpBwe5j7UjorryYso+91GzkII0d71IX019gjQa2ulC7o+nw02u6L8Ar61ZIOONobI6d5Qc4BRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006415; c=relaxed/simple;
	bh=5QMUaB3UItvdOk2MFBD3uzK1qE9srvOCD3sKMnkMU7w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L65HwdCbipPRLn+SXJH5pbLQaA0WDpliFghzjh8ZHVODvk29fG/tdYNmY0BylRKOhmXpUUsNt986jGP0dlZZ2vYZmV0U/mip1onuqdDRtxxuZoTgLM/3n5xBguo31yV3yqm7qwrSbtcay7w/aJWtiO0tiCapmhMGcYK30tAAD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQcv2Wfs; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so3896478d50.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764006413; x=1764611213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hvHQdU4GV30EKSntbN+1hV2iN97Sxz4IGxkWVntgLM=;
        b=GQcv2WfsBNv2Kpc2YsojWOmO1oHedfglyzir1ERidEop6Z8cMHcgRT8gl2Ku8tKn7o
         hBi9m1oCD9tGyam0Z+J63xafOOLN7Kgqjjl9oeY2n52wgMrIbvkPfXdmTNLLkjhLNUHF
         OdTQvrsbzOqu0ImtwJCGXIO5wxfEuz1ZGiComjQYUw8y2m6Xh+c5ELsKrkhtUvZNozjP
         J923F+I91pmK0OE34zUyTnsZAMebTPSWzM3r962tnx6O303xGy35dqhptnQjFB945off
         MNmYudhuFBLibwEo/FeyEl/fXI/q6dt/XCHczikDbNargi5ECQlRCtaVtTS1bngswy/a
         8Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006413; x=1764611213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hvHQdU4GV30EKSntbN+1hV2iN97Sxz4IGxkWVntgLM=;
        b=MZGy7aThFL0Y0h6wNVyIllOc+K0xizdf4RZQoIPiDN3yRuhknPR8UmEeAfhSd2NOzE
         YXyxAxn064+VCtt79D6Hv5sQXTl/YFuq9Jr1sJt4sxp+foGmc5ryvT8KuMmIGuMicoCn
         GkdIQUjROU1QITkRgShNd/K2ZdYkMk/8L9ZnZ11BksjYi7CgAt/LAyFE/1ENEJN9VZnj
         Dsx4YFrlkgu7xjA8fp67j2hkFTU5AWkQE7zuifhRyEODrktaIkhb7g+2fk3YYgz0fUi+
         Q4Wl31ol4wQB4Gshgjq3mzesGACkCMuRkm6s9bKAUvWuTicDJigRo/LkBUuFrmFXnfLM
         1tnw==
X-Gm-Message-State: AOJu0YzOomL+BGL786i/iOwL3uDa8WiwyUmmDf6RyzS+E57oagMj/V/5
	yU4mrYAm3KGfeAcTEKtZbUM9dfRWoURCDx1aYky2y313iOtuZZxQ9fLf
X-Gm-Gg: ASbGnct1e5QG7K+esZ3jnvYZSfY94jIQUrb7oGrnz3nOgVSrpj3K8D1mW9CH6P3bDEK
	2j2AnzWoVbsurIOk+rt0gCoJNtX5RpsRVT+RLeBfqqyFzYVTZePzkwHcBirppzx7d5sKgG2QuuP
	Fa2zEcRLW04RnO6p+2xgra1Uf+uqtE9NaudPnJIXsSMVDnC6evM4MasR2H1piDAVn1y1Q5lCNVF
	XyXF9FEAIU8VfbxVIfwXf77xqJZy8UZK449YoJm0rNVemoWnMJjUk6GcCTSGbuPkZ/T8YdMWLgA
	a4z7h1S3oe6FwIAwdt7tzSDP/qswnffp0gm4DjSn3GfYYdC5uIEqAxb8VN+yWxnas1wIPVculrK
	/ju7yxS7DWWaCmKyWRXVbnoY63KHhHmhishxc/N2mO7x9TTzhGMd8XYZO+4werEpPkY/VVzQvr5
	VfZ47cGO2ZWpnSSvSXPjHp5l+gh6mWUCz9C/XyGx/BPpjfkZU2hywJswpIY52O9YtsBio=
X-Google-Smtp-Source: AGHT+IFZLS+sg4uY4W+GnSk7FxLFLQkNJQifO8MidMav+DX9v0PbFy6py458azKZF49Wq/pFCb5C9w==
X-Received: by 2002:a05:690e:4298:10b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-64302abbe69mr7439363d50.36.1764006412975;
        Mon, 24 Nov 2025 09:46:52 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a5decsm46733137b3.21.2025.11.24.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:46:52 -0800 (PST)
Date: Mon, 24 Nov 2025 12:46:52 -0500
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
Message-ID: <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
In-Reply-To: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
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
> char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
> by when switch default case taken. raises following warning.
> 
> 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> initialize these variables to NULL to fix this.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

These are false positives as the default branches in both cases exit
the program with error(..).

Since we do not observe these in normal kernel compilations: are you
enabling non-standard warnings?

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



