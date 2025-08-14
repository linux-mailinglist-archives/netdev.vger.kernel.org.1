Return-Path: <netdev+bounces-213779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87904B26903
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0868E601DE2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF612FF69;
	Thu, 14 Aug 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzX+WF0P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BDD17A318
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180430; cv=none; b=Mf1jBtYRO8OJnyNuCEoS5WOYaLJHSCrgajRD01WOzM9x7kCvQkC65rG7iDzvSugVHeJzMJ069TJNWfH7DuP2cBOQW8S8NkUHsvD1a/X/peeJAz2g3oAjuu7HgjkTUytxTRywiCNc0syvmF5UJuBUGVlyA/jklOZNbRz9qGCmJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180430; c=relaxed/simple;
	bh=acXpdSDKHWdFMlxajAmH3VUeCckl96r1JXcA/2bVx/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8rCoSh/e/Cruc7aWq4E8qoPOh2Bluohxbc+Ux2lN2Ba7KKtvPlkywhf+ngpChVzc7Cgd/m+qiSUzYKWinylXt6UK5ktgYAVNtDJPBK5SzUirSOQImm1/IQKTSvv1DnuIXdn3VXKyGOA0eAKjZq8krZJ4a4NDalV4x1Vjb4HaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzX+WF0P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755180427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtYfJ9RH+AAwmnMCcyZ4ZMTwyj/DWoplK4cU6GNbyzM=;
	b=MzX+WF0PoxMwNLXvnbWCozu5qgfFSYk8NDqpm4Lthvv7578SyqPlePvuLDhLW4qZVE73N7
	6kqa9x3niLKkJWdgprIN9bzoDEyVoxe9XgYKgjzsgMhDwS9in5+gVbq6ZrQe/z7WyobD7g
	SXR6KY2pLqNirFnISxnKtDYMAwAGK80=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-8hBUs85bM9CoDrD0kynfTA-1; Thu, 14 Aug 2025 10:07:06 -0400
X-MC-Unique: 8hBUs85bM9CoDrD0kynfTA-1
X-Mimecast-MFC-AGG-ID: 8hBUs85bM9CoDrD0kynfTA_1755180425
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1ba17bbcso3329525e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180425; x=1755785225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtYfJ9RH+AAwmnMCcyZ4ZMTwyj/DWoplK4cU6GNbyzM=;
        b=NjdvzMCs99+u5BIu5nRf7RsK7QoEoaBe4NorVcL269olJNu8act89DAQbwomR19GkW
         Klv1e4EWGx1qoVY2LmBHTnqXu3Uj2amhDEz8Mqv54v8wlF3YdKkiLmwWJg7qFE8er+7N
         xDKoNa48k1IFXrMmtICUHDt7/AXaEfJT18BjcpBHWsrfo2kN91PoyjpCvFQY+6sHFDXF
         n9g0LgvQlFiFZeNzbIV1YcZMKk6TDFfRqc9qpyRPTFyWZhGf5g3HTsivm7T6d1GyCKwM
         c8DVjub/W60nxf7lKbVhUb9JLh+NmPhUZZZqPQtpXytscd90VIF740Ms3UAkfT+HkwDk
         GxnA==
X-Forwarded-Encrypted: i=1; AJvYcCWq875WtxFtcMTJN1NeU0n13aJYAIKNYyCBzx7usNYSuVDwTYgaExgnwcyOUuteybx5Pq1WOno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjqVSmOelYewimz50yoxwGYgnX2CdikvjFGCL3R29WwhBTDe1Y
	m7SrvIueT5HWloikzBp+tSlYB7vPbFE3ixElZ1cluhobBLp8W4HKLfBlWqZYOxadW2J3+KjSzbJ
	DMAZn2Pqi/e5jrxeOrG1T3bQ/LXzXyBbXFctL6HO0/9nsvEi9/pbEU73VVA==
X-Gm-Gg: ASbGncsHflxl/QRIOJQ28+0kRVJMFMjPyN9wWhM9OCqflvgolDl7a3UqyVbAcMlPR2+
	eTVdVZsZa6/vnzf9lq1Oj61j6PUqZS/AfoDdxmMOBMP2wrcogyvWdzCn4GTc+NwGy0hN9EhP0D4
	ncG1myQut/xi5cP0BDo/eDeJE1TBwM8wl+UwA+IkLSBYc3aaS1Z+0gSXUsxroE+kzCuHvFld/Bw
	czFqyuucetOx2Kp6+OWqYsJKda7XBS5f4Sie/xZbOfMPIZp9piw7bV783wNlBes8Szabc3B4dMS
	MLFgjjFRHVIvP84PBHIMA1P3LUhQutz3hxI2UefbMtY2lqMl1BmS3lzzKi6T6EQ4kxPOwT4XSY3
	WBcdgmAZln2A=
X-Received: by 2002:a05:600c:c87:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45a1b61af7dmr23267105e9.8.1755180425292;
        Thu, 14 Aug 2025 07:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUlJHJGv+ucVxPofUBW3bDiYjm/evcymy0bUUSjSXRjjZ/bqJEm3uHiAKc3QytHXAMHUCjiQ==
X-Received: by 2002:a05:600c:c87:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45a1b61af7dmr23266775e9.8.1755180424872;
        Thu, 14 Aug 2025 07:07:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6dbb51sm23846085e9.14.2025.08.14.07.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:07:04 -0700 (PDT)
Message-ID: <324f1785-80a8-4178-937a-c3d6a47e6d79@redhat.com>
Date: Thu, 14 Aug 2025 16:07:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/19] psp: track generations of device key
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
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-11-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812003009.2455540-11-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 2:29 AM, Daniel Zahka wrote:
> +void psp_assocs_key_rotated(struct psp_dev *psd)
> +{
> +	struct psp_assoc *pas, *next;
> +
> +	/* Mark the stale associations as invalid, they will no longer
> +	 * be able to Rx any traffic.
> +	 */
> +	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
> +		pas->generation |= ~PSP_GEN_VALID_MASK;
> +	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
> +	list_splice_init(&psd->active_assocs, &psd->prev_assocs);

AFAICS the prev_assocs size is unbounded, and keep increasing at each
key rotation, am I correct? In case of extreme long uptime (sometime
happens :) or if the user-space goes wild, that could potentially
consume unbound amount of memory. Could memory accounting or some hard
limit make sense here?

/P


