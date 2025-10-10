Return-Path: <netdev+bounces-228497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9BEBCC750
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F88B4E27B8
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05EA26B761;
	Fri, 10 Oct 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KERdXAdw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307470830
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090543; cv=none; b=EAV8tssSmk+ZwRRCvh4lnBFcWUBk/WWi3abTmeFuy2kOavlvl2/ud9LNJtzFIiHTA1JBhc8dD2WsFaiOf4nMoUPOEVN0mdQ5NA8f0ediQApJEzEpXphX70HHAlk9KP5w6BrcGJaNHFjp2tTS/Xerxpf4h91uCflcJK23SPzLldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090543; c=relaxed/simple;
	bh=huBZl2ZVgKVDp0vhnCSEqeRysXHxlUKICdAlhcaoQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbZ6FKGoo6HZuxVqTp+kcx/9ao3+Gda8fR9wwsRncS4eFmgLwb3UubSPq3x2aRFdDm1ZUE0JRCa021WblrYx1WmxcVpA60e5J6PKYwv8roPKOJ6Sewl6dmyMsZw18H/o8k/42XmD82oaTo/wXYdYuNhydSNZAeYsxe+muams3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KERdXAdw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-789fb76b466so1763374b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760090542; x=1760695342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3WFlXEJ/gSBsMTRphzuDKkXK1TylSSpVK1C8MARDlY=;
        b=KERdXAdwsg8Fbzw/JvwXhGR55O8S2hGPljUxtKGoIhCuBR5zlXigJ2w9ilANUwLBfH
         QMkRIYVyqYuUg1GE7xhR8o1TW4yB8gev8gG936/Dr3AUUQZO/z5nP7AD4UCxkO1arSNv
         wOwfcYb/6/4FTlytamoOFoF8f1oYaI3UDFNOH5AJJ78wcyVUDGQZ4bIJav8n2x8av50N
         sG1rO/mHgWcX3NRA7cJaVMx63nusYY51Nki1BW1o5LAESucAKeRw+YklSEmOMov36oJ6
         wolIMvhXTIOhlWsHgwiXZ0N/kBcCSmRG5Iug4xE67WCPRStnTjsNZKLZt0Chm6dq+tq5
         vLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090542; x=1760695342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3WFlXEJ/gSBsMTRphzuDKkXK1TylSSpVK1C8MARDlY=;
        b=FwcGTgWJSyYaaQX7mffmk1Wx9zkGj2fFqRMhi4dyGT9C5KPuwk/loYMbTyepqVR2Tf
         WKalHd8CEOH5ka6rVXb0omRUdTPMmaVRqyYjcP90xbuzciolgP0ucLDxSRbB7XbOcZnp
         TW07jATeGgMq4Kwzef7x4HBWjRjxWR8VlcWIaBB8rTHANhVMOa3n3Su7hevesMmyL2FV
         IIaITvf/DloR6h8kmcXxcxcQ+D7ZqAQDHmmzvR+yZ2jIh2dGRCVh4aetAcJwkQodqHmQ
         zIlkI7z9wFHmt4/acM+UNjlLhE9mql6ph8emz2ilvBEDFcLxSL9AC3IjBPkbcTe6hRdj
         rNlw==
X-Forwarded-Encrypted: i=1; AJvYcCWTIv5olJrfwoFBIsfwkv9qBk6pcR6kNQRwSnymUPo2Qh8JCkft0Uq6fwd6ROmkG8f3rrGXdEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRrjsRfVFuyu9QStSfsyWlan0cuXNx8nU+yC6G6OAR+8Drdjw
	xeqBzLF7v9WV6/cQgSh29Q9s1QUvy+AvcEGePTxjyu/y2KDXFY22M9N7
X-Gm-Gg: ASbGncu9PuAoHtgk4QREAEHU4KrzdT6EXEcqzISEwOz19Dz7DPsH1JZ9jOB8JSD/Gx5
	/gv+nUniZ0GG/eU8KMEjuLChe7wz83Pc18AIFJZINi7u1ZshtuQI9ZM4stHx6DXfKrF06qH1Dqq
	Q1sfI/y19ZU5poyALrCWcW72zyArBUn3GeZ9KTpY15bQrbfYaR5fwp1TNzTYYqGdKjly8ISU71z
	OJUsMfVVAVITYLUvK2w+E+SswFJ+OAUN927DMitksvSBRcX03nOOhqefFJmIP4FEn6+B3C/DFVh
	iU311SmD3kpfAUgLnZ1RZeezKaZHelZL2tPSecx4m1j/w3Fk3bgrqT5FN9vIs6Q080zAIH1bTZl
	Fru1o92JKZq5GAhjkotoU27O1VLoRS0pmh+PUf1zLuMTudFVuoijedOGC
X-Google-Smtp-Source: AGHT+IFWAlMW0WY6WsB1azworHAHgQMMUZ5qCKpyy62RTrsHc5HavlvwNfewBf16V5qGThJVcvJeqw==
X-Received: by 2002:a05:6a21:790c:b0:32d:b925:4a8 with SMTP id adf61e73a8af0-32db9251fc3mr8682285637.3.1760090541604;
        Fri, 10 Oct 2025 03:02:21 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992db864c7sm2370015b3a.82.2025.10.10.03.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:02:20 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:02:13 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net-next] selftests: net: check jq command is supported
Message-ID: <aOjZpSSOVZg9INj6@fedora>
References: <20251010033043.140501-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010033043.140501-1-wangliang74@huawei.com>

On Fri, Oct 10, 2025 at 11:30:43AM +0800, Wang Liang wrote:
> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
> the test will spam the following log.
> 
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>   #       Got operstate of , expected 0
> 
> The rtnetlink.sh has the same problem. It makes sense to check if jq is
> installed before running these tests. After this patch, the
> vlan_bridge_binding.sh skipped if jq is not supported:
> 
>   # timeout set to 3600
>   # selftests: net: vlan_bridge_binding.sh
>   # TEST: jq not installed                                              [SKIP]
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh           | 2 ++
>  tools/testing/selftests/net/vlan_bridge_binding.sh | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index dbf77513f617..163a084d525d 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -1466,6 +1466,8 @@ usage: ${0##*/} OPTS
>  EOF
>  }
>  
> +require_command jq
> +
>  #check for needed privileges
>  if [ "$(id -u)" -ne 0 ];then
>  	end_test "SKIP: Need root privileges"
> diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
> index db481af9b6b3..e8c02c64e03a 100755
> --- a/tools/testing/selftests/net/vlan_bridge_binding.sh
> +++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
> @@ -249,6 +249,8 @@ test_binding_toggle_off_when_upper_down()
>  	do_test_binding_off : "on->off when upper down"
>  }
>  
> +require_command jq
> +
>  trap defer_scopes_cleanup EXIT
>  setup_prepare
>  tests_run
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

