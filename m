Return-Path: <netdev+bounces-238672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA94C5D3DA
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B703A356D37
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FC314A91;
	Fri, 14 Nov 2025 13:05:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA163148C6
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125502; cv=none; b=ZwCU1dXVv8S7SJdSNmej+wEWu0qhgZ0aQSGBJMQcU9jHwKwR3esysQNIdS65piYXs+YO8M488k4BdX42ayOMKhvoHHTO76BLM2hyKnv26XnFnHQ/JkdsJzorHroTekfHDduFk464JmoqGjggRkl3+Kd1gQtIaJsVFswS3InGweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125502; c=relaxed/simple;
	bh=I8LI/9oAuWD9/ZQ1oJzv7f3ctwdwjfPABUn69OWCtVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx0RMN4PRkjrZG1mYyM7L6J5UdMidLVouTkwW6sAy1qmZTD7iLut5RAFov6KoPBZHuqNkdIXnAEkewztOF4LzQZFDHAT0GMEXCBxcChz4rNmbTgB0+Pb0L8ALMomOECut9JHcBnzgbsEA3LHrA0rtFr7fh6m/U4z3ZkRJNHkPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6cc366884so679814a34.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 05:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125499; x=1763730299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck1XVH9Ez7CwgIs5ofF7HjrXpEiT5Xu2K8aWk20owYY=;
        b=C69GiH7dNRGW43AJrlkAFXz6tfFQBQWH2J+xFkaQM/OxGMwxBXWsS16qY/HBaF+mTf
         ifIdnMySYix5O4VhJ3sn7Ejcs2Ms4NrFvazZRp9V3WtemXYHJ5uTlIvgfSuPcBnUvIYv
         x4434cLHYzfMsJZo0xEw3UN7RnIFF6n8VkrxFLHJGkNQaUxz0uknQJY4J6xU8DUK5LJT
         iIaGgW2RdTspt9Nsi4Bu/jrptpNysV4e36cdG9tYUsecE8D/LQLYxveP8Jq6AG2UCHMC
         19Sl59NYYTRCE/bVdO/SoXveA0wvsYkdSPxbBOvq2zI6S8JoY/5rEEJ6KVSergRd9e2j
         W5OA==
X-Forwarded-Encrypted: i=1; AJvYcCV72UsEsLMY3V/bjWSo1SYAsYCs9VAEvhkNv/rfZa08SRnq6YhiVVZ3QgKe/vOjjX3p216afuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrNnWj3weCyX85YLGUgsm6oHE1w31zUjyzElPC7SqmRzinBfX
	vz2MWw7zAdu8PLf2IvqaCNovs/8L7dbkobwyWIHQgOm5J6GobdddDWS1
X-Gm-Gg: ASbGncv5n43n+TAaXGqEi+llZ2UvkYckCoXRoT9drY7H/HDo3/xAhW6q8pJcWR+MN8V
	9oGEIKhe9ToITW5tyjChXoOiosmWgtYERN5gj1Q6rtNH8mFTIwh/1U1Ujv4iUYaWLKgGdNWO9uG
	2KBdX8x955GNHm5PP+xgbFlmCiYn0eJH/LG4rOEmkfytkoD+MNXjWr/Pms5B+KqVRu04iBSe4Xm
	xlZStgX2RaIaGK533xinfYK1c3N389xVrWgF56t2CyLwSiCtiL63azRcogQvbco0vrTw/Aj4+Kb
	22yW9K//gNvj2voCJvwWTZ+5N9eiG6Rbw05KuNBtXH9M0S8jmG6NduhLI06GWWuAu5jlMKWe5yn
	kGQHrwlsdbDTDh5uDWN0OZghKWycqKkRBRImzjwL5ufFtaZH3gKTUtHHSC6yFnJK1gARzSiofWo
	gFo8k=
X-Google-Smtp-Source: AGHT+IH6fhy/rVKXbgtj5HT/TCquEIk1gVsI/N4G4rGCwXXQ0SZCVjLtK8F4Fx3qRnaankb7UItddg==
X-Received: by 2002:a05:6830:6d9d:b0:7c6:8c48:924a with SMTP id 46e09a7af769-7c7445d79cemr2043835a34.25.1763125498597;
        Fri, 14 Nov 2025 05:04:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a283c36sm2538431a34.3.2025.11.14.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:04:58 -0800 (PST)
Date: Fri, 14 Nov 2025 05:04:56 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] netconsole: Dynamic allocation of
 userdata buffer
Message-ID: <ucjifexudkswvaef5c25hbzszdnzsnx3drdaqkf7ytdpi6qzk6@pd46ih2slt3w>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:20AM -0800, Gustavo Luiz Duarte wrote:
> @@ -875,45 +875,61 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
>  	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
>  }
>  
> -static void update_userdata(struct netconsole_target *nt)
> +static int update_userdata(struct netconsole_target *nt)
>  {
> +	struct userdatum *udm_item;
> +	struct config_item *item;
>  	struct list_head *entry;
> -	int child_count = 0;
> +	char *old_buf = NULL;
> +	char *new_buf = NULL;
>  	unsigned long flags;
> +	int offset = 0;
> +	int len = 0;
>  
> -	spin_lock_irqsave(&target_list_lock, flags);
> -
> -	/* Clear the current string in case the last userdatum was deleted */
> -	nt->userdata_length = 0;
> -	nt->userdata[0] = 0;
> -
> +	/* Calculate buffer size */

Please create a function for this one.

>  	list_for_each(entry, &nt->userdata_group.cg_children) {
> -		struct userdatum *udm_item;
> -		struct config_item *item;
> -
> -		if (child_count >= MAX_USERDATA_ITEMS) {
> -			spin_unlock_irqrestore(&target_list_lock, flags);
> -			WARN_ON_ONCE(1);
> -			return;
> +		item = container_of(entry, struct config_item, ci_entry);
> +		udm_item = to_userdatum(item);
> +		/* Skip userdata with no value set */
> +		if (udm_item->value[0]) {
> +			len += snprintf(NULL, 0, " %s=%s\n", item->ci_name,
> +					udm_item->value);
>  		}
> -		child_count++;
> +	}
> +
> +	WARN_ON_ONCE(len > MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS);

If we trigger this WARN_ON_ONCE, please return, and do not proceed with
the buffer replacement.

> +
> +	/* Allocate new buffer */
> +	if (len) {
> +		new_buf = kmalloc(len + 1, GFP_KERNEL);
> +		if (!new_buf)
> +			return -ENOMEM;
> +	}
>  
> +	/* Write userdata to new buffer */
> +	list_for_each(entry, &nt->userdata_group.cg_children) {
>  		item = container_of(entry, struct config_item, ci_entry);
>  		udm_item = to_userdatum(item);
> -
>  		/* Skip userdata with no value set */
> -		if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) == 0)
> -			continue;
> -
> -		/* This doesn't overflow userdata since it will write
> -		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
> -		 * checked to not exceed MAX items with child_count above
> -		 */
> -		nt->userdata_length += scnprintf(&nt->userdata[nt->userdata_length],
> -						 MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
> -						 item->ci_name, udm_item->value);
> +		if (udm_item->value[0]) {
> +			offset += scnprintf(&new_buf[offset], len + 1 - offset,
> +					    " %s=%s\n", item->ci_name,
> +					    udm_item->value);
> +		}
>  	}
> +
> +	WARN_ON_ONCE(offset != len);

if we hit the warning above, then offset < len, and we are wrapping some
item, right?

> +
> +	/* Switch to new buffer and free old buffer */
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	old_buf = nt->userdata;
> +	nt->userdata = new_buf;
> +	nt->userdata_length = len;

This should be nt->userdata_length = offset, supposing the scnprintf got
trimmed, and the WARN_ON_ONCE above got triggered. Offset is the lenght
that was appened to new_buf.

>  	spin_unlock_irqrestore(&target_list_lock, flags);
> +
> +	kfree(old_buf);
> +
> +	return 0;
>  }

This seems all safe. update_userdata() is called with never called in
parallel, given it should be called with dynamic_netconsole_mutex, and
nt-> operations are protected by target_list_lock.

The only concern is nt->userdata_length = offset (instead of len).

>  
>  static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> @@ -937,7 +953,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
>  
>  	ud = to_userdata(item->ci_parent);
>  	nt = userdata_to_target(ud);
> -	update_userdata(nt);
> +	ret = update_userdata(nt);
> +	if (ret < 0)
> +		goto out_unlock;
>  	ret = count;
>  out_unlock:
>  	mutex_unlock(&dynamic_netconsole_mutex);
> @@ -1193,7 +1211,10 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
>  
>  static void netconsole_target_release(struct config_item *item)
>  {
> -	kfree(to_target(item));
> +	struct netconsole_target *nt = to_target(item);

Thinking about this now, I suppose netconsole might be reading this in
parallel, and then we are freeing userdata mid-air.

Don't we need the target_list_lock in here ?

--
pw-bot: cr

