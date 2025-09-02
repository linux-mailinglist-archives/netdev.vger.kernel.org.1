Return-Path: <netdev+bounces-219098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00877B3FCEE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD01F205239
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770D2EFD8F;
	Tue,  2 Sep 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jU3scmdQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48346145355
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809844; cv=none; b=ql7FoOktN1NbmEvacRRPdE/NKek3m5bthY3LvobvlY+AqUfyFbd4LgRMrQn0S1ENhp2p8ojQvp9geUH7tZi7iFrYZvd1F9mUJ2qGVf03YAsFXD4fDcxAx6QdObEMpK1PloFUvbaGJ+YhOU77YmHvlPs3OwvwAo+1AU8oim53HZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809844; c=relaxed/simple;
	bh=6hesa9TLeYxv3q6e9DhRIDI/mxQpv+JYQO9aNhgs8e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejyre74XZquJBcLSBabRuNCmMzp+G3RFDzgYXnagnZ4wzXSiYZTKTBF696Ark3bn2FcoTFWLTcxx/QIx3HGB4ifXLKIHk8LdzrAvNVdnrBdQwcUse9nh9r6YS2x72kUtcoBNbgUvFnVq4h0PB0wgMhpsv0baJnLDyBCEe0oq4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jU3scmdQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756809842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo0/Mj2/+9yOGLss6nLTorYX1OMBEsZpD1lT6UPRfdI=;
	b=jU3scmdQwmkVH2+vA69840e28zI79uYVRFJn0aohyGZlHwe3yAdQzl+4JVnLFSvJ8Rr5Xm
	+SUY7c5YZYzGyHArYkSTtB4lJF6Ztg1xTTfZJPEXAxS+8+WJxV6SXrKvqHwPtX+Tj1dR1y
	lSzvSQVMKKc5qyIcrjGJ6Sw8z0n2PqI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-x1FvC9xEOzCgT9SCBXQUXg-1; Tue, 02 Sep 2025 06:44:01 -0400
X-MC-Unique: x1FvC9xEOzCgT9SCBXQUXg-1
X-Mimecast-MFC-AGG-ID: x1FvC9xEOzCgT9SCBXQUXg_1756809840
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso27115485e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 03:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809840; x=1757414640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo0/Mj2/+9yOGLss6nLTorYX1OMBEsZpD1lT6UPRfdI=;
        b=p8Ofbj6a8lmnPfjuN+3ufzG1y6UFJOreKudeTsRoQgAM2RAAAld9yOQMuu9MkRbHBw
         hc6PehgdpwdKIMKqW/KWb4DLfq9s4Ba8IBpJx0eUbiMcto0t2OIw04/Z7icLJ/vJIdzy
         kH3UbuwCXoBsQRre7orRVWpXpSV0w7SqhT//mDplpbaSH7lfC0nsjSLPgowifgcPIf0i
         Lid3DEn81FnM7VHfNl9bedKoCwWuGbQxUhtE4BKvUIm9IG30du09aBy2QbjqKiMpHzu3
         joPm74MwXe+UtkEjkDHUcQ7DjwqoA6Vjwjs20lvSocLKlB5BkQ7/Df6ARFeQ7lpfPikr
         U6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVRBUYG4o7wQqANRZmjuSxH1g2IXYUveEqhcXW85qC3PbvSF3RI+i/8fLVl/tvEsNDlxk7zehI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QtlPta9DoDGkT5dM6uN1vYcL5VrndK1XoTL6sEa4XhVHW64o
	TxOvl9fpgdrIWPypzoFAtWa5SIpZr3VZL1Dcy/vc50nwpl7PKPAadSkMhpgMEOjq8xu1v39pCiq
	yPgR2dxMwYdRiN4N5ksbiJD4r+ctp3gDaVsk+WLw1iNrYbh3Q83ZmVDjLKw==
X-Gm-Gg: ASbGncuOUgFtnxR8qezWwArK58bc4gljIhXY7oh24C0y+RUPK55MvnAODQeBk8M1k6R
	vA/rvOFdyR+F+ct9QBG64VDMrjT60X7kvhFC9/Ol22kHd9bvsWbfINupx/j/YwbXjD4qyBKgWwm
	UN5yXt9pAd8eJuiWVyqAfSWYuL6Y7AI1eV5AL3U0dpTXYr6Dz0LnYAVsKzwstV2/rCKzG32ZSJs
	IDNbkUia1Eu7GOHGYcf7EMfxkPQ2Bk9tbJlN8H0G6sLlwuTGbv78dVuspRo0gFxSSCGxhnXUF7k
	yyA7afC/ZRFSpn0tpeVF9rwr3QIKVZxEzTp5mIw+HzhzzHCeU0i6IiLDWp3RnPLVca/yobbnNIR
	Gb7tg0vBIFio=
X-Received: by 2002:a05:600c:524f:b0:45b:8453:d7e with SMTP id 5b1f17b1804b1-45b85526a68mr93034995e9.6.1756809839699;
        Tue, 02 Sep 2025 03:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD+Nyf/fbAZ/gveofQdn8RFyjdqlaPnTraLhEZlhkMD2OZGug7tcHAInCh6y2cJsJ1vckjFQ==
X-Received: by 2002:a05:600c:524f:b0:45b:8453:d7e with SMTP id 5b1f17b1804b1-45b85526a68mr93034715e9.6.1756809839302;
        Tue, 02 Sep 2025 03:43:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d643dsm19520553f8f.26.2025.09.02.03.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:43:58 -0700 (PDT)
Message-ID: <c282cd8e-96c5-41ab-a97b-945cc33141ac@redhat.com>
Date: Tue, 2 Sep 2025 12:43:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 08/19] net: psp: add socket security
 association code
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-9-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250828162953.2707727-9-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 6:29 PM, Daniel Zahka wrote:
> +int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
> +				struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct socket *socket;
> +	struct psp_dev *psd;
> +	struct nlattr *id;
> +	int fd, err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_SOCK_FD))
> +		return -EINVAL;
> +
> +	fd = nla_get_u32(info->attrs[PSP_A_ASSOC_SOCK_FD]);
> +	socket = sockfd_lookup(fd, &err);
> +	if (!socket)
> +		return err;
> +
> +	if (!sk_is_tcp(socket->sk)) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    info->attrs[PSP_A_ASSOC_SOCK_FD],
> +				    "Unsupported socket family and type");
> +		err = -EOPNOTSUPP;
> +		goto err_sock_put;
> +	}

It's not clear to me if a family check is required here. AFAICS the RX
path is contrained to IPv6 only, as per spec, but the TX (NIC) allows
even IPv4.

What happens if the psp assoc is bound to an IPv4 socket? What if in
case of ADDRFORM?

Thanks,

Paolo


