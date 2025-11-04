Return-Path: <netdev+bounces-235420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA2C3041D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617854FB30A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129B2356D9;
	Tue,  4 Nov 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn3KyAXG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ov3OiwST"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A07311C1E
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248028; cv=none; b=JT9AAgagPl3f6Fs0349yMNgmNfu7ck+OfT3fBR4lkkhaumhGWGaw5afJ9zWDnmI8/CiqVPPBMDB3MVW3TzJJNyJR+dkYXgE8zG6AuN7/wKJKX//l9/OSSAzc5CnJTlL8raGD7+qoOxNY9l0w9T+nVfCxD0wyrRwjY+9+Ix/qNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248028; c=relaxed/simple;
	bh=pUKJPrLx0M2WMbh/ePs7QzJ4DazqZizbc++rbelECWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZyq1mOwujbJY9FKeu9bbX+4qmP/5RWNy+UaLKvM2CAATXxJf3Erih1uI1hfT8rY8eYwUXMnDXF3ALgNH0Dyatcl7IAgaLNEA/0Nowss53ykc0Fw3yhVul9dqGu12KvVCZvl7VoXt68iLL1ewPc6f11qQc4vx+qfeX9vrYqJ3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kn3KyAXG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ov3OiwST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762248026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltNFnYEQmixQZpMP12HbSmJnNGHT1YgJ5lkpfeO1BNA=;
	b=Kn3KyAXGFaiS5b19tA/Xo/GcCvtAMwxEnGTsMhSrwoxeck7VslrR3/W/Zwk/D+O6Qb1Twf
	R87s0lbVbAAPtuMp0Jld2K5UKI/m3btHhTbuQ3nKfVOkvi56NchQYV9i0zsC1UEkpZ6glt
	NqkZWztj9hffJ2eF/rxB1UCVIHVF0M8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-8Ig-PrUkNu-FDBL_YZzjSw-1; Tue, 04 Nov 2025 04:20:24 -0500
X-MC-Unique: 8Ig-PrUkNu-FDBL_YZzjSw-1
X-Mimecast-MFC-AGG-ID: 8Ig-PrUkNu-FDBL_YZzjSw_1762248023
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4770eded72cso19472585e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 01:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762248023; x=1762852823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltNFnYEQmixQZpMP12HbSmJnNGHT1YgJ5lkpfeO1BNA=;
        b=ov3OiwSTqzZ+PqgaPUK2pdkKejhplolMVaqodVcienexwYM1mKPACT1MA2OmPbuPy4
         Dq/UP4yx858h06omh6Tn6IuLT1RIqTeM9Qdq2RzAoEVUvx1Ql8hWt39jmWcbRNXyR0Jo
         2iYep/1Li+3yfLaGVo49r2RhU6s9nBmg0TSK5DdhkV5Uaxz1kWoR8uGqQD+yg72o2mJq
         b0lS5HITU8p7suFwnVpSSquJBbVIcAYxlK1aie8QVsTzKDi1VY9DWBsTPE9dNi98dYqz
         cnOqrit97OcJNmuJPcFfKPJCPqGtfrOPgcKhtcbOEW8E/iQhD+i/+yFFWubK5BFZeaER
         6L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248023; x=1762852823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltNFnYEQmixQZpMP12HbSmJnNGHT1YgJ5lkpfeO1BNA=;
        b=Ik1/SQvt6zeiytfDyX/y3FlRG3GYF9FdZtZ0qWnlcmgVIpG31gx6bSzTQDwqgeONsu
         mNGmjjgTIY9u+grHrK+UvtKxy8iV0i4cYgXwhVhF06X+CDhVZyrWjkpImWjCXIVdwwah
         PIpOq5AEQAMzrOhOldRdrbYdVDEpxSJApy5BwOFjhHtOLEXF/apR+8KPFnve+QNXAUuM
         ei7cKQTHAHZEprpzMZ65ZIAomyf/ia1sYxH2S2yMfyE8wB8kmdhHlEEF29z4mgcC7yJn
         9mCBugXHHqk6j/ttoY+n/WaC0NoMdaQDBSpPnO6e8lfuNi4nSOS1OstrnHh1oSzWn9pf
         0hJA==
X-Forwarded-Encrypted: i=1; AJvYcCUrSNzH+MBKgyZpVpcw8QWZpkMU9uZePFKF9J329faZ6BtdFBtnvaAoNj7Wr42wS7ROgn9Fqi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY740YuN6Kx+pVVOxHc23iEUC3AFpZkHblo02oZIjC5jdJXGK5
	2y7o2q5+ho7KqBj6lvnvufZQce3T41PfEylGBsTue/NZjpsCVBkkz0fmEccz5Pf3zCQTzmlRFf7
	P5T2CcnHjTpmdVLaDTHbdPs9+N1kcJGFunsqMCx+rPZ8EVmyJcfkNWScmgQ==
X-Gm-Gg: ASbGncusSNHdL/1dpVlp9B3a2x7QHpTOviFiAMXeKTaDNjWqxUUT0Yv1XnBBLS1z8bc
	XY6G6ohl5kmyzmxfB6fbVW55yIPpGgYwLXcUM4maiZw3+xmrI65hZgKaWHrd2vgMvSbvjWvOsA5
	Lcn/tsYoaacGhdxtgHzzLieT4FJ+4qolclthKB8Ldtbohc+tqYxRa/YJAnsRSRzcAQU6Kdi8YkI
	XziR98Rs1IEXLcaXRh+uXmXk8p7hg84K9GHwwjbWSfRdYkosR11gaSS2xFc+ZxQohskFs8/lQUC
	Ra0mP5pm8H+L2HJu8y5L95un26cQsr/emuKt4OXxNzBv7t+fjxxnYRdRuFXeMsdY92Ggj9ix/jb
	FGJMtwB7bxpazEAp4ABZz4dn8HD0vR3eNrxLRAscoet2D
X-Received: by 2002:a05:600c:488a:b0:477:5639:ff66 with SMTP id 5b1f17b1804b1-477563a0172mr7272155e9.13.1762248023169;
        Tue, 04 Nov 2025 01:20:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/p/JinMYxs2wrDLzSGvdns88BAErQtC1F7WbaqV2NdVF5IW/VkWgEi7rHVWoViH0BqwGtQA==
X-Received: by 2002:a05:600c:488a:b0:477:5639:ff66 with SMTP id 5b1f17b1804b1-477563a0172mr7271755e9.13.1762248022677;
        Tue, 04 Nov 2025 01:20:22 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdef7sm3539621f8f.43.2025.11.04.01.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:20:22 -0800 (PST)
Message-ID: <a0fee8ef-329d-4286-aa8f-b569b9e4ab03@redhat.com>
Date: Tue, 4 Nov 2025 10:20:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/15] net: define IPPROTO_QUIC and SOL_QUIC
 constants
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <c02ccb3edc527cbb1aa64145a679994dd149d0da.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c02ccb3edc527cbb1aa64145a679994dd149d0da.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> This patch adds IPPROTO_QUIC and SOL_QUIC constants to the networking
> subsystem. These definitions are essential for applications to set
> socket options and protocol identifiers related to the QUIC protocol.
> 
> QUIC does not possess a protocol number allocated from IANA, and like
> IPPROTO_MPTCP, IPPROTO_QUIC is merely a value used when opening a QUIC
> socket with:
> 
>   socket(AF_INET, SOCK_STREAM, IPPROTO_QUIC);
> 
> Note we did not opt for UDP ULP for QUIC implementation due to several
> considerations:
> 
> - QUIC's connection Migration requires at least 2 UDP sockets for one
>   QUIC connection at the same time, not to mention the multipath
>   feature in one of its draft RFCs.
> 
> - In-Kernel QUIC, as a Transport Protocol, wants to provide users with
>   the TCP or SCTP like Socket APIs, like connect()/listen()/accept()...
>   Note that a single UDP socket might even be used for multiple QUIC
>   connections.
> 
> The use of IPPROTO_QUIC type sockets over UDP tunnel will effectively
> address these challenges and provides a more flexible and scalable
> solution.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


