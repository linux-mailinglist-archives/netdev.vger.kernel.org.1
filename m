Return-Path: <netdev+bounces-155803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726EA03D40
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E83A3A2BD8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987B15886C;
	Tue,  7 Jan 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnmdqMKv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7A50285
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248002; cv=none; b=aIBoxT+1l9BJ0pxXgSZkTS2nL52nG8XEiAcToaiWJqqNaw8bKQXu6bDsKiVmIpqwKnndvdihj+dN9h/6r+eD+ceU1uN0yJTyrzrBMhZxo3hg9WyySQHOsK0pn6xLvxDYM1wE1fatZ/HKiIMcKdW0WO+exixhex46MQK2nUP+KYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248002; c=relaxed/simple;
	bh=yHQU2rcCMJbOpH8i38ux62FuED5MQNDdSyujVPU1q3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqxdZBzCNWhPkVmnurtuGTxaJ1epQte8DPK5V09ZeECYm2TzSd2l0c8pnfhwiSAy0yk7yYMDdhG8pfEfPNLlUj4ptuL8MiqW6FDQPjzLf/tz2TIIw/d62ji7rz2e+keMBla+9/xisrLutVyW6b5vTwyRwH8yR3KTlMBjCiUiFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnmdqMKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736248000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPJimbMZinT0ai+upGf3T1vG0FvUtH93H0cNYYfAQPs=;
	b=cnmdqMKvVpCYhApRzlDHIQdjQGGTnxz5fvTuxz2J8GKIjsTmrKfcyrQw78UnGIPolN5Nkx
	utQNZx4I7aJsZ0drBHHtkawGOPwW5gx1O5eeSPsFrEDX/LC1MmZNVU7mqtzZ2FgUtUjh7W
	Sm6LCY/sI+aKKL8KRKV4B/y7qbc6qeY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-_qxX44tpMTaHlYTCpO3tkQ-1; Tue, 07 Jan 2025 06:06:38 -0500
X-MC-Unique: _qxX44tpMTaHlYTCpO3tkQ-1
X-Mimecast-MFC-AGG-ID: _qxX44tpMTaHlYTCpO3tkQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862e986d17so6747508f8f.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 03:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247997; x=1736852797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPJimbMZinT0ai+upGf3T1vG0FvUtH93H0cNYYfAQPs=;
        b=tHAaeOGG0RAumygUV/NpvyLzglZKMI1oTPUdiL410Z4/F4CnyD8eE8Jt4WoVBnlcZe
         xzUKh89suEqaUMhELZtg3aYEE+4aZAb4/UuxOciRILFJOkRnawLcL9ToMHDBydta2tLV
         b4YmhJw/PPOqmDZ0ypN896V5RTXhCzNb6Ba3CExumGN+3+VYFam/VTxET4Q2b1RDUXIh
         5s6gc/98GPpyhQxnakh1+IY4tGFit+9e98T1q13+uf7B4XKDY1Exc5xjcRiACv5vmUe+
         BP5NdBlWisVQaboaFOSk64lZ1GX/xaKU8YZVaF0WzPwsdMaUn4az+O99B+C2MTNdYY3B
         LazQ==
X-Gm-Message-State: AOJu0Yw0gK2XI863UFZvgEPfUfY2yh1R7bGv/BbrlxWnnZgkzEBU8pZg
	Lg6VKL4uS/gOzDjC4zRDStBnmkNVUdicwp6lljmDa/rTRiRNViwD/wRSIyzqbgmbUXkX+uW5qj6
	s5X5I0I9yXjg5bl49xIcK0ALxism4DBgRHL65xiIPRLOlvXNdFhdn3w==
X-Gm-Gg: ASbGncsRmWrNQkWtLYB/Z/3p3ZpWv4UhmbK3DxQ+eYdajMZB/E87LhRRF6A6BsCWaB+
	repSp2JmJP2rHFIW191bxUsYEn9jzMY/BdDbu7UPKgnu5SOgIFqH4M05bhSnvkfKOJhJaHfbZVz
	mytbDJ6LBrS6ylJHnGnsTt9fQi75IRzh/aigDLyIt948WW48+ZNibMVCms9Q+58IgAe7ZQWCXaa
	aPNp3iu86I11YoULd5h275GusD2QaOH5GP+a28dYqcpmt0yhnKVfDlU86TeoJT4SJYwjTnvqa3U
	jB2oXxJrtrw=
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id ffacd0b85a97d-38a221f1716mr61307863f8f.21.1736247997488;
        Tue, 07 Jan 2025 03:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFmk3/PYqXnHu0Jn/YyUVvLumS9KNFwMeBkRBQ7CZVKeJXurLr13AffEesyBse+lX+yQZiQA==
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id ffacd0b85a97d-38a221f1716mr61307827f8f.21.1736247997116;
        Tue, 07 Jan 2025 03:06:37 -0800 (PST)
Received: from [192.168.88.253] (146-241-84-112.dyn.eolo.it. [146.241.84.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828ba0sm49324810f8f.14.2025.01.07.03.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 03:06:36 -0800 (PST)
Message-ID: <97d430d5-f139-468c-b9e2-ef60e5d5cd34@redhat.com>
Date: Tue, 7 Jan 2025 12:06:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] netdevsim: add debugfs-triggered queue reset
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, dw@davidwei.uk,
 almasrymina@google.com, jdamato@fastly.com
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-8-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250103185954.1236510-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 7:59 PM, Jakub Kicinski wrote:
> @@ -723,6 +726,54 @@ static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
>  	.ndo_queue_stop		= nsim_queue_stop,
>  };
>  
> +static ssize_t
> +nsim_qreset_write(struct file *file, const char __user *data,
> +		  size_t count, loff_t *ppos)
> +{
> +	struct netdevsim *ns = file->private_data;
> +	unsigned int queue, mode;
> +	char buf[32];
> +	ssize_t ret;
> +
> +	if (count >= sizeof(buf))
> +		return -EINVAL;
> +	if (copy_from_user(buf, data, count))
> +                return -EFAULT;
> +        buf[count] = '\0';
> +
> +	ret = sscanf(buf, "%u %u", &queue, &mode);
> +	if (ret != 2)
> +		return -EINVAL;
> +
> +	rtnl_lock();
> +	if (!netif_running(ns->netdev)) {
> +		ret = -ENETDOWN;
> +		goto exit_unlock;
> +	}
> +
> +	if (queue >= ns->netdev->real_num_rx_queues) {
> +		ret = -EINVAL;
> +		goto exit_unlock;
> +	}
> +
> +	ns->rq_reset_mode = mode;
> +	ret = netdev_rx_queue_restart(ns->netdev, queue);
> +	ns->rq_reset_mode = 0;
> +	if (ret)
> +		goto exit_unlock;
> +
> +	ret = count;
> +exit_unlock:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +static const struct file_operations nsim_qreset_fops = {
> +	.open = simple_open,
> +	.write = nsim_qreset_write,
> +	.owner = THIS_MODULE,
> +};
> +
>  static ssize_t
>  nsim_pp_hold_read(struct file *file, char __user *data,
>  		  size_t count, loff_t *ppos)
> @@ -935,6 +986,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>  
>  	ns->pp_dfs = debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir,
>  					 ns, &nsim_pp_hold_fops);
> +	ns->qr_dfs = debugfs_create_file("queue_reset", 0600,
> +					 nsim_dev_port->ddir, ns,
> +					 &nsim_qreset_fops);

Only the write callback is provided, but flags are RW, this causes a
setup failure in bpf offload selftests - while trying to read the
current status.

Cheers,

Paolo


