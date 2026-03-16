Return-Path: <netdev+bounces-268201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLpUGLoouGnhZgEAu9opvQ
	(envelope-from <netdev+bounces-268201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:58:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 113B629CDED
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FD62300DCC3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DD3B8BBD;
	Mon, 16 Mar 2026 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXGU0H2e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB53B7B8C
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676722; cv=none; b=kIn7eshvUexlZndlOs9zKmLhJ0mMU/OIjM/uShvmECmyvvrPPrqt8/hATc2U3zlLmiIrL3B89P21wkdthsjpPQWAAaJNdcB4/aB7v6Jr3Qp0j4ZZ3oIAIphH7AJkPeLOeijtnyXUHM6CH+XhYZ3MNquzA28KSUgWCt+A4vgSCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676722; c=relaxed/simple;
	bh=lfUQTdN55+K2zrn5Z6NemyHi5doQni/FTVmfMm7xoww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3SAvEOrGYuxj5YMADCiR+jkQCDqUoCzEmk2RPJ8liuMyCNL7IWJWqvBdyzjGIT4/gj+DEqSCbJqCHZxdmhqoRDs0/kYh/Djf+bqPIkuvXkf7b357yAGl+/tvkohk6eTjTiuYmDv4/lhqzVV3joYpLtmIDbdcRLo5r1NvTWbO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXGU0H2e; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128e4d0cc48so5320995c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773676720; x=1774281520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oI0YC07KGXAjPpWTbGejd64dv/sN01+A96JnEtMrvM=;
        b=mXGU0H2ebz/gUxea+1M26iWfn8arEFuhh17Ub8vg/Smop/7/vWsyqevQWRUuKxCsVP
         fzsLPdzaBmfiBM09frbuR9xX51EOhNkNkx4ALBziD3SQGS2+7m1AGmpK7/gQ7oHSrgBR
         o5pvKDVUvTh8Maipd+4m7fRscDAQcQMK1Y/6c9I4WZIU9mn5Mcdx+OJQfS096tTRvHMc
         qi54Th89tPUxuEcoowRxKdvK49jqsMiXG1dxpAQqvQyzqrYE+Iut7kNaLMnRJEo2efv4
         U/UIrCCl8Hb9Mb3ly5WZtBOjsVwmF2cR7cQ+WPXRDjvdVjdcQQpp0N0QgfwQk31naMOf
         gjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676720; x=1774281520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oI0YC07KGXAjPpWTbGejd64dv/sN01+A96JnEtMrvM=;
        b=O9uE9WE/lwRP65wGBb0nmaoB5Oc1HWywwlE2scJChnCwN04YMNefkeSWfx0LkMSQGN
         2FhhEt6IoxTl6pW3GSOaeJu2dkIqa4lCCfYXzT1IWg1mVHg6lvxZs7/0RaUF+NXttZQN
         iwfziqcI+plQRP/yHg4Q4GxDJJzkPyEUj9S3UR1WzuMDTJUrBOrFFMPPFs77Yn/sEqfP
         6Z8/rpxVWx529Fr6kJzq3zM3lph6CCu48cDpEpd9sbWpKniDkpAT5j9CrH7e/lnbHduz
         SgM+RSgwGhVZt0sQikRRdn+iSeLUfqze4Kj1U9Z8oQ/THisfIe9DJf8p/ZOoDmo8Q3wp
         Zeyw==
X-Forwarded-Encrypted: i=1; AJvYcCXh48BY4hCL57xdUDojHhy2fc7UyVZK83tLU1G0FsAOhaNCDIivT+fBJ8yfReysSwCeYfDUQ+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGdkE3tBE8GJKFkvcyRU9QVoGw5fABziIO5JK7/D0ThbTSYbJ
	xtyc7QZZ3TBGa8lL0rQq/Kg+2yO3IbBlwVPCnzpibHP97tp0epB50axhBkIc
X-Gm-Gg: ATEYQzyi1BxuiqLRUU5v0cHYpr4+074gSo7y/Y+4YMdKmyORrh2AW41CdOizJJ3FT9d
	6zWH7rbcU0qEDOPuie1FFZtOqe2vnoZ6bPV9kSWSsnhivDWfqM5XiMz9EzSA3iRBd9OBrm/uc/h
	142EYalF1BZmc0WwEmGKmMMlGcmEx++ngsfeML1JTTcISPeiR8sjIZc/iy6pBONkuvzJf07kcas
	QrsR8gwMz6/+0kF2j6UyFB4JAm4tAtR5hXo4SZrHtG/BuVMty0ePYQWS8ly5/wudjVSV4zsgz/2
	EdVGEfXpVYx+1cseA/EFl3+tOvFhkZbdFatjHNf5TG2SvHQN8IoxSew2NgxjGRdi6Ty4v2xgAJf
	qBqfUunaR5X/7HLfwE7gVl4HoM4HcT04F3lnT93y4xze56RQlQ9vr2yYjTkS0UR7Cv8PfukXDQw
	4SsVouvW9ZDqhotmi261Z7D4Xo6JoVPwNEucTj4kwzVaCNDdp72HVYOZmxvtI806+UxPaU4V4SA
	GVsfm3tEeyyAwHVoQ==
X-Received: by 2002:a05:7022:4587:b0:11b:b3a1:714a with SMTP id a92af1059eb24-128f3d96020mr6389740c88.12.1773676720443;
        Mon, 16 Mar 2026 08:58:40 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62b2100sm11713446c88.8.2026.03.16.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:58:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:58:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 00/11] net: sleepable ndo_set_rx_mode
Message-ID: <abgor1cTBnLnPrX8@mini-arch>
References: <20260313145113.1424442-1-sdf@fomichev.me>
 <20260313123844.4a3a6c13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313123844.4a3a6c13@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268201-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 113B629CDED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/13, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 07:51:02 -0700 Stanislav Fomichev wrote:
> > This series adds a new ndo_set_rx_mode_async callback that enables
> > drivers to handle address list updates in a sleepable context. The
> > current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> > with BHs disabled, which prevents drivers from sleeping. This is
> > problematic for ops-locked drivers that need to sleep.
> 
> missing TEAM from net/config
> 
> dev_addr_lists failed:
> # selftests: drivers/net/team: dev_addr_lists.sh
> # This program is not intended to be run as root.
> # TEST: team cleanup mode lacp                                        [FAIL]
> # macvlan unicast address not found on a slave
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding/results/557081/16-dev-addr-lists-sh
> 
> Also something fails in TDC but IDK who's to blame for that.
> Too many buggy things posted at once.

👍 will update the config and will try to find a more quiet slot on nipa
before reposting.

