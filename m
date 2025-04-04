Return-Path: <netdev+bounces-179282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C115A7BAF4
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9623AB7DB
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2A1CDFAC;
	Fri,  4 Apr 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="x+wbjugO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4F1B9831
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762771; cv=none; b=EzXMBW1clSXG/Jhy3eN1ehEJ6roclH2JwdQqjvS2eSBfgJzSHEH+b7LPw8KOpjDDLx2tCXJiuEikGgbiLmskm+hkPq1C03BSRUhMLu0F30nwRdR19KbxatYbwt2LypFiEjJp6o56+5QMY1tSR1Oausyj934CB33YrY2W9b+1OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762771; c=relaxed/simple;
	bh=WnyNM3GpsP0Dl/EId0H7TcY7rKiT5psqWlpftW1stJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE+G8AJLKQYmkmX/eKUL1bmCYy4Iv8hRVN7+iuM4vcECtkg/otmCSwU5gmAo1p+/dDBKnEFVylrdgOPX1zXmbpK3taZrLVpOzqrGNKhWIle6f7wabiRgcjMzkqDH5IburuVEkc4XaXd2nuCrKVjeqEobYUnJF+Cq5KDqvirOxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=x+wbjugO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0782d787so12637255e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762768; x=1744367568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2wKx5nN9Yh08oxBM+SAYrINkO6o3TgnEJYxXlm+aSM=;
        b=x+wbjugOupzYufIJ33EKFpgIUbqBudOW1/MeQZN1ZpIhn0MIRv+E+C1SA4FXgWvV5P
         K3OyU5Cwa+YlKalRWzBD8u6lCAVhP4lAbbfJWx5URoQwSGqZkH/JUkB+2My4hoJ+azE+
         3r55UzzgPbqxEUk6c9Fm1TdIctZ6CqeDMQRy8d02Zo5owDFUmvaw7UAHZKLT+OqA2z7C
         COSMSZa2WEbxi8fgRYYbZyWCjR6IS75+7kCdiQCvW3N4KU1Uii0+0aq35g1mdqjvJ8CX
         607iwBVxK+Of2XybwCpFwNhXv4ul1ahynrZjZ3tmINEFPLuuu8qw+bKVmVdH5sP7R9ob
         RGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762768; x=1744367568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2wKx5nN9Yh08oxBM+SAYrINkO6o3TgnEJYxXlm+aSM=;
        b=aHATJDwB8FlYubc/Pyb4SyDO2hLmyvaSmBgs09M7LSRFxhMZz/s7EjSMXwyazK9wX+
         nfXope7Xgxm9gWLPx1y4wAKgz4XSIdpou6okHvIOpwWungs92rI1RMcLA342y+k5N3sJ
         +Bx3alvQytiP464BnEfHFhsPlTpaxZzA6ofu6/IJzwCYYR+R96Ehm0cX9YPeMqFsfw8Y
         QtETYIlQPmrJYtkqUIShyCaHdf/hFK3ni7D9SplOkUDU468QZUe6vnIIgQ1Bi/x9+67K
         ZsT2FBtd8x5XnVA89b5Oqhz4p5dpij66U6KgNNtaCUKE+ozELF4bV9t3b27mD0pXpzqZ
         4lxg==
X-Forwarded-Encrypted: i=1; AJvYcCW0p4XW2ukrMjxRRyQicpJTD0kW7XZfgfQOF4LfGBMG6b5z1aJUWxbPsrn8OU52CK9f3K2I08o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm41ekk2baV2ycXaU+7CgJ6hkEKQSQXH8xKTgktxXPJPt7Ky1V
	KkIVxABPbMNIsHi2NUoGHUmuXuhz2GI92aAZLWIMjd2OdRc/rfSQqzJVl87c1RUdh4r3iPSgRyW
	wpZo=
X-Gm-Gg: ASbGncsPKksE45cXgBi8oh25rb1+aq58dIpV5BQ2szgQWbfVLXsvh6hTGtTikeZxkPQ
	DnFgR5AJIdVefmtQyj/MUihnJpITUbmckSJMizWaG63ix+9RSi6NPgL2/XK2eY4tXQj/PgckViu
	qKUsQrDtQGBPsXZAe4JBC1Gw5HrrU+Kycg/rWnlPOJSBzaal7achXWv6SnVI2hi0k843OeQBLX8
	qlzHRX5bg/jxihkmNxvpgD4lZmBnCpXTvbQwDH5JXhcPZPFnIHpPIxlMg+u7wpRZs2D065nuT5O
	qm1yQCfFXKrHLZhiIt2gJv89KcB0xOPVmRIZH8a/+l1sECuJm1/c9+FxMfmrTCg71v0yyqyRm2N
	W
X-Google-Smtp-Source: AGHT+IGO8fmQu3PkBVX3WgB3spSPBYmbkyK4bnv09NZgbf/NpGASHw1aY9SMIkHC/zPGMnGJxz/Nvw==
X-Received: by 2002:a05:600c:46d0:b0:43c:e8a5:87a with SMTP id 5b1f17b1804b1-43ed0c6ba07mr19731955e9.16.1743762767856;
        Fri, 04 Apr 2025 03:32:47 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096b9csm4050286f8f.13.2025.04.04.03.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:32:47 -0700 (PDT)
Message-ID: <cd2ea9ca-ff8d-47a9-9fbf-68fbc19d4bec@blackwall.org>
Date: Fri, 4 Apr 2025 13:32:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 iproute2-next 1/2] bridge: mdb: Support offload failed
 flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
 <20250403235452.1534269-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403235452.1534269-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:54, Joseph Huang wrote:
> Add support for the MDB_FLAGS_OFFLOAD_FAILED flag to indicate that
> an attempt to offload an mdb entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  bridge/mdb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/bridge/mdb.c b/bridge/mdb.c
> index 196363a5..72490971 100644
> --- a/bridge/mdb.c
> +++ b/bridge/mdb.c
> @@ -256,6 +256,8 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
>  		print_string(PRINT_ANY, NULL, " %s", "added_by_star_ex");
>  	if (e->flags & MDB_FLAGS_BLOCKED)
>  		print_string(PRINT_ANY, NULL, " %s", "blocked");
> +	if (e->flags & MDB_FLAGS_OFFLOAD_FAILED)
> +		print_string(PRINT_ANY, NULL, " %s", "offload_failed");
>  	close_json_array(PRINT_JSON, NULL);
>  
>  	if (e->vid)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


