Return-Path: <netdev+bounces-306397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i+xeD7s5UGosvQIAu9opvQ
	(envelope-from <netdev+bounces-306397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FF736542
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lNC8h7iC;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306397-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306397-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC2D305661E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8927157487;
	Fri, 10 Jul 2026 00:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456B11CA9
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:13:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642425; cv=none; b=ixu0IklDRcA5Lu9se1hzjcvQq7+2FX5CU8g6F9r86rJn4W4KS4YNBNM+OjtrtOYSykeHlmD7KrIQFsUCZ5zrBC0muRBGP88KGilbjasWrw9ZnAsUP9r9jqoYdjn0WNTRxLUBOB8mcapY1LJPWZI7EFLX2UfcFNnFP6NfYWnjdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642425; c=relaxed/simple;
	bh=j6cD37JPU3LgqmeqiWNo7VSeZ5CTob89eIMYZjloUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f++Z+xF4yVZfShAeBWDI9KrNNCSGKogCUmwlCbyuA0D+nQnScvkY5QCSXLFMUtBfNwG6EWi3Nxbt5td2mIV0QSNN12CaFiFO5U8jjhs/II69B/co7/ohyH52eJI5TtO+Hx5ZF7LqtIWYyr35tr26eGHlOsCfQZQ1N8gz0k9B6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNC8h7iC; arc=none smtp.client-ip=74.125.228.1
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca696c4b152so123761a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642424; x=1784247224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NWbkBRfCnrkzUaFcgrHq6MP6NIH7xy8BwEhQEhBxfHw=;
        b=lNC8h7iC24zMPg3MEoptz+cTiPliKE4B5S2WVhbn6DadtHPrk+IV2APD6qjHM7sSrR
         5hySUUiAJSnZR2bqpUUg6TOXCBZPWDJHBPCIXlJmF+wHa6DoBzQBEH2mwtFTQBu3vgW0
         ITKGSIhN0W3j1XEBAhWkV4LV+sX4NZqFldV3ftImLSkw46F+26wAfoPkzaur1g8kutya
         vGAYNUgh7ocls8qBTONfbCorCvQAcEYGPjKSW82kKj/lUmFFYYACjJeLBsJRI+O1xLr6
         mNW3HH665Z56CLJFbqgecMlYQs12aZGE31YOYT4X998AbnNj0DGHj92PXNdhxwMxHZAb
         zNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642424; x=1784247224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWbkBRfCnrkzUaFcgrHq6MP6NIH7xy8BwEhQEhBxfHw=;
        b=BUzgYRY1M36nbzui9iTUX10G8b3LexDn9qwiCZVgwFXcXX1dEPDvHd7BssHcjOoYMx
         LMyiQaPuJch6tSMaM1FWIz50s2f5CJP3t4ZeEVu/3qt+Lb8vkbtCSiMvQh7AqyVCvJMd
         mTIWYI5LN2X/OTcFCr+lkQeDBP4jjsShLU844G0nsEb8qQxNiOiGpwAcT6yfhM8V3mqs
         Nzd14dPu1La51LzCezt1qZG1D4H0x8lNGTnSvOVCN2DEP0+A/5XbgDiePiLciBgl1Unp
         o29MeMwxUP0/HMle+S00Nahgmygw/xSaq1KC1gq3Vs2xMazQjzg+kFu7z803aQkafkcx
         HV5w==
X-Forwarded-Encrypted: i=1; AHgh+RrEif5qnh3Uf8Xd0MDkE+O/amIpHHnR5VyJeBAhUvPxeWPQqLjaAHE/WpMQi9SfGg91GQkygWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBitMoVfKGadEOHdhq6y6sIlRbXYRQvIR0Lq2WZTMECdRXKmt
	4mRJfySfNeaxh1ndZXiossCEpInvjYPBKtpe75ue3fSiKY+d8TyREGUV
X-Gm-Gg: AfdE7ck/dUnlq5iuYGs1H/G+yOo6CvvVJMEmb/nwkZ0FIPW5CUcaIEacoEXcQSCD5Rz
	wms1iojzwS4FP0dGBYJ4LJsdC9JusdgnVtpn955MEnZTEROa0+wyif/z/E7j6doTJkkwEA4MbS+
	gtwVAMp+6F9PfVM96whbBUBBiEDg1kUgutn9f+Imuw9ZisUahLIF9m1PUdjj4ExVDQiTFHuHts3
	hJxoniAAMs9EuzlinbHj4gISSPRhxoi9mnPp7gl1yZsL2gPNr9G+Uc00Bl/JQ1LWyV44PkBi9w7
	ud2lmSaF2KfZaKsvd6nMXETJxIeOzop+WJ9zsvh2qKdFBgZnaH1efbEVcpKJRjbAu7R5PuK8lnb
	L2LkjZaUrSKWlGT6VsulTHnehuSaaCKFp0tHDCsvWsMeNEh19M+u7cmPnU0IkNioyeVCi/9+3rA
	qUawWC81NYd3rEAB3P
X-Received: by 2002:a05:6a00:298e:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-84842d4ea41mr8051586b3a.0.1783642423638;
        Thu, 09 Jul 2026 17:13:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84831643b9csm4834109b3a.6.2026.07.09.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:43 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:13:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 5/5] selftests/bpf: add bpf_icmp_send no
 route test
Message-ID: <alA5GARDnZkg8RT1@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-6-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-6-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306397-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid,fomichev.me:email,etsalapatis.com:email,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 761FF736542

On 07/09, Mahe Tardy wrote:
> For normal live cgroup_skb paths, the skb should already be routed. The
> exception is for test run via BPF_PROG_TEST_RUN with packets created
> via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
> would quietly fail by returning early.
> 
> This test exercises this and makes sure the kfunc returns -ENETUNREACH.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

