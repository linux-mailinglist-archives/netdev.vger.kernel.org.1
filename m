Return-Path: <netdev+bounces-250941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C71D39C18
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE65D300160D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF36BB5B;
	Mon, 19 Jan 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUVIeRYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001F200110
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787123; cv=none; b=c+cdZ2jkTCIOLdr57yVNtmcxDNbm7ChrjkRVtfwud0+pkUjbRXdlI6Gllsh3VFhrcVBOQov93u0cAN/yueM4HXQSZI/YHkJb1/Xa0w4ijh2xPHELdXZFaZJFw2jnu483zjhPhbxGqzLTSTdjPayxz6yS1KL129ovx82RB2jO+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787123; c=relaxed/simple;
	bh=5h2I0YxtJwPsjkMG3LKxuVHco95YcSlv7gHxMC0uIpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uebqgoL+SPUl9fY9H1HTwFRy3La3LdrVkAT2UVPQD+63XfvmurJ7ybpYeQK2DNPIHjMFYSyheLBsEzbZWlb+7V3WiXWGT1SxFcDM6kAf5E9yjc9rN6OAmVPhIxYL54CKSj0NaRspBR6THdp5w7PKNIl5YDQ4ixa6Nst+Y5HBNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUVIeRYz; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1233bb90317so2954890c88.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787121; x=1769391921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQSVsnHg+O3hcpMh47evjUqhwH0d7PCJ/jfr3jwWCIE=;
        b=cUVIeRYzrbTX2DaItH/uaBeIROoR7Lbyg7892DQkPAtQew7uReexSwfR+Bs4GTk+Au
         lMpPzaErZpFsuPdLMn7S26LnxI0bsrWX2IE8nTzvI4aje4uiUYR+35Rud2JpfQnaD3ho
         VNTe6IB70xnQWYB1yxtlBa2/F5B6iHspE2R77SXhFwm+yMky1evbGMRd9j8EOOhGr/ZM
         zR3mMjQ1BxVP6YPqYQAvsZLe0TK5NWC6+47IcztAjR9AXxhe+j0voVTHbZEJl5wilbc2
         Cry7Vm0L12ZzoVg7WwBTjwlsFUljLELELKxLwCEMfY1RhQccV/ezvfdzRZyEHDdqaGT9
         A6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787121; x=1769391921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQSVsnHg+O3hcpMh47evjUqhwH0d7PCJ/jfr3jwWCIE=;
        b=mbSGhrnGQ5NrT0Yi2WMbpuExRA1LLLq+r5EmTYGMSdD1VhfdjGt8PVXckx1hUDiSx2
         +13yUHumh/ulg/GuyeetMm1TsC0UtJtBQFGZncFBu59mdZ2JypaDCy8VSS7V1MeoInxm
         tS3DpVvkWUIRAUbxjFvNoWrTUyw9MTmHERQ1hIpTr8R74AUd/q5KM3CdlEv0eo7AvXfH
         Fd95Gp5EmuO+gNEDPTDlEpg5TLaryo0PNg/HfnVIaIkgs3ihIeGm2t1bs4dIB8eHVbrV
         hjK6m1iWYrgLGuhJEJKeVg2FTmL6hVNNijgeBhxG2B7cih6smb1Vc2Pp4gpkpphBAyYi
         qtsQ==
X-Gm-Message-State: AOJu0YxlAEasFlG2toAIRc8kQkL5FYxDNn5Ta9xyMmTuflPLI10GlF/w
	4Bm1TfbJKvSmM/lz8TDCHXdmO0sYCY7QqHKlU6YpWZzdipODAFgQx6Q=
X-Gm-Gg: AY/fxX583PKD7Dc1nRtsoA39nf5YQHrN+in+SeEGi7K5iqY03f8nuGQLQRNL27fnGwI
	ICGzTUVrZs9ZxX297o0HE1MsD/iEPXYrM0HW6ACnCe8RDq71tVuY4y5Vg1YbAAGm/+Y4yf12sty
	tPmM1+vNmnCfLMJMFYYE8bEzZrEZxiBfnT/WzJu4q984BCRUqPoTh7+V/p024/hkrTbfEB1VJQm
	P2vTiu0YAxKVyBug3yjWatoD5WADgho1IjSeWGCi/LaTpvwvPrJL1IATaA3QinWKlDg0z3UJFi8
	IltO+EasdeZiebD8ntTkmx+Q9L0GOxSroT+ad9Pc7CpLZvwidHk3DoguNhNAhTrLdy3jSYm2Cy+
	bEWmvdyBmWeh0uHk4uMzRpRFeWZrnBL7NPfvpBJ2JHoDq5Ox5srVGWVZKp+OuiwYQubztSoQI1Q
	jmr6qJLiNZR5/I6/weTUu4vlGlTJ5TrLnXDUK0qnMt0cUtq946fsW87BG2bZ7HY7dKhv7VdEN/H
	aUrhSdPujxdazv3
X-Received: by 2002:a05:7022:2486:b0:119:e569:f865 with SMTP id a92af1059eb24-1244a923b8fmr6685305c88.2.1768787120925;
        Sun, 18 Jan 2026 17:45:20 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac5842csm13609302c88.1.2026.01.18.17.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:20 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:19 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 07/16] xsk: Extend xsk_rcv_check validation
Message-ID: <aW2Mr5Wbd4S2QJbS@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-8-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-8-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> xsk_rcv_check tests for inbound packets to see whether they match
> the bound AF_XDP socket. Refactor the test into a small helper
> xsk_dev_queue_valid and move the validation against xs->dev and
> xs->queue_id there.
> 
> The fast-path case stays in place and allows for quick return in
> xsk_dev_queue_valid. If it fails, the validation is extended to
> check whether the AF_XDP socket is bound against a leased queue,
> and if the case then the test is redone.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

