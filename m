Return-Path: <netdev+bounces-231155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7AEBF5BB1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15473421600
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BCA313539;
	Tue, 21 Oct 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nosdlo/B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B332BF59
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041793; cv=none; b=q2a/yqCob9tpzIhV0kg/T9tTt+QKyswZDThUrIuGnDLF22yk+Kt1ETRgs7VClkh5AzMUdXngAqGNTalD3Y0EMVXplNTvUlwDuvJVKIPGIxICLbue0oYCP7UIlJm60eoEYKKdJ8Bm9XFZAwvKhzrGMAkJTyGotXxdW3DflKh3v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041793; c=relaxed/simple;
	bh=k4u+Ihr8vkpW4CkylMViplglhKtMWRS32gog7rSU0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sI9Js0+3wnjVed+laz6eQKkgVFLMJZ1znBcfE83Fh7dtSJdk6YQK41aSnWuwPbIU0EFsmJ0M5pg09ZiG/SJ2J8IWuLVHnrfdXCBXJ+EMjvvExjhi8ZF9yxNygjwA6vr1DRrRGen14869Tf8Hjy5SYTkpRj46OPPEhexAf6Nk6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nosdlo/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAfOpf2VC9r1Aq/Ba8aQCcqsQ1cmp5ERa0FiKT74Dxg=;
	b=Nosdlo/BkFLTqHyC+X/Wh5QjqmQwK5lXaYkFIqc5KXxnBIco1Z78dCqnGYXTu4OAmCuciJ
	/5LcKMT7wqID1gBmFGRrvhtQL4Q8TQSaxQsXl/2K3RvxbKtOcOTzjViM7x6EO+huO2kKzY
	9HyQ6uYtkH92LfbfCFiMXkR/UEko6bM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-Pfi9_MDJPLOfd1KEI8hC2w-1; Tue, 21 Oct 2025 06:16:29 -0400
X-MC-Unique: Pfi9_MDJPLOfd1KEI8hC2w-1
X-Mimecast-MFC-AGG-ID: Pfi9_MDJPLOfd1KEI8hC2w_1761041788
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-427091cd689so1924254f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041788; x=1761646588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAfOpf2VC9r1Aq/Ba8aQCcqsQ1cmp5ERa0FiKT74Dxg=;
        b=fi6DNx+dtYllifZ+1+DP32MnSMm3Jg5MMN6ctS5dKGJ1up9j9yTVqqTi9W6VcB6pWV
         G3iof2CUMGT2lOz9IdsIzo3AgxT5rIoaEIC2e0OYoJGPLB+WkdrOeyeXirZOKnAJ1K4s
         d439pSyjhGxqfe7LrQc5h4PVPRfoKhbQ0Ta8LZjK0zM2EwS4GFmHFXsvQt3WTo8CjSWv
         BBYoCq4dc2QP1GmVGNCN7w2R4RqruoaG80vl0FDmXFazmx9fkEJwwlNWHV7Lhq0v7aG8
         IoLwi/yuNzGY77PguM5zv5s8RH7lkqDGZUfadiekFWfgq0x+4jm6Q0L8pD4WW1QO2bKO
         zoWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIXsWVOvByVToFwpYX52YqUPJEsAn0pbbvz+i6ZqV3R8GHt5RfcvwYMh4/2oJnHBhvVKnwocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHWw631//UBmoMMIfwA4ulx2Ro1crkZ8gTK4aY3DTur3p4D8V
	73whooanMGdDTl/gsvTZIW5kTG4+R8pNr0EkFQ9VhYqGs6oFlN5f4hC17DA5epGoip1ilMsGDT1
	wfTs25tXfZ+Xrc6fg3ecenMUGmoUmXmSEGflIP8y4PHhaiIJ4poXI2UYlXQ==
X-Gm-Gg: ASbGncv74g7/a6JjGMYyMVKmmYD4qUU//ixkQPJDcysQYrXluOEn88iYn1kG6SIVTa3
	WV56TW5QhWdoFn3v74lAGRCZ8TYBxqbtxdQBal2Bz4TGPJ7RqNj5mFPZIgUoI/7ApkVsAPjnbvk
	N6PaJeTAC1qw7Bq6JfKS9k/fHLw1EXGGizDIW4ZbypoIPT/cbZdRkRewQ3dCjZwKFMe4v59h1Ry
	lTN1R4wtlTmzKQGdcCVr0U7NFvCLtlrQBL4XfvYZUbky8cV9vPEFXYQ0VSrJoC/CRp2j+dyljjX
	95LY/ARFM5oMui53ayHna38Uo8wR4BupCvFPV4fQJxgux1NAmYFysEfAAZtUAlhHnkDvraLBLUJ
	RcKw3KLI/aCND7745DmHZIsYQx14Wn03OukzsQ2OpHcnGVeo=
X-Received: by 2002:a05:6000:186a:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-42704d1441cmr9403287f8f.7.1761041788477;
        Tue, 21 Oct 2025 03:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4jyuQMg0K8Aws1Lv1y09/ZSf7i4qxnIBZGs2bQmXI8n6Npjep0Yjfazd/+t0xT4RT5Y7QQ==
X-Received: by 2002:a05:6000:186a:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-42704d1441cmr9403254f8f.7.1761041788036;
        Tue, 21 Oct 2025 03:16:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm155390235e9.8.2025.10.21.03.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:16:27 -0700 (PDT)
Message-ID: <1e779b80-4645-420d-8cae-36c36c3575e3@redhat.com>
Date: Tue, 21 Oct 2025 12:16:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 4/6] hinic3: Add mac filter ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <dccaa516308f83aed2058175fdb4b752b6cbf4ae.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <dccaa516308f83aed2058175fdb4b752b6cbf4ae.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> +static int hinic3_mac_filter_sync(struct net_device *netdev,
> +				  struct list_head *mac_filter_list, bool uc)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct list_head tmp_del_list, tmp_add_list;
> +	struct hinic3_mac_filter *fclone;
> +	struct hinic3_mac_filter *ftmp;
> +	struct hinic3_mac_filter *f;
> +	int err = 0, add_count;
> +
> +	INIT_LIST_HEAD(&tmp_del_list);
> +	INIT_LIST_HEAD(&tmp_add_list);
> +
> +	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
> +		if (f->state != HINIC3_MAC_WAIT_HW_UNSYNC)
> +			continue;
> +
> +		f->state = HINIC3_MAC_HW_UNSYNCED;
> +		list_move_tail(&f->list, &tmp_del_list);
> +	}
> +
> +	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
> +		if (f->state != HINIC3_MAC_WAIT_HW_SYNC)
> +			continue;
> +
> +		fclone = hinic3_mac_filter_entry_clone(f);
> +		if (!fclone) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		f->state = HINIC3_MAC_HW_SYNCED;
> +		list_add_tail(&fclone->list, &tmp_add_list);
> +	}
> +
> +	if (err) {
> +		hinic3_undo_del_filter_entries(mac_filter_list, &tmp_del_list);
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
> +		netdev_err(netdev, "Failed to clone mac_filter_entry\n");
> +
> +		hinic3_cleanup_filter_list(&tmp_del_list);
> +		hinic3_cleanup_filter_list(&tmp_add_list);
> +		goto err_out;
> +	}
> +
> +	add_count = hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
> +					      &tmp_add_list);
> +	if (!list_empty(&tmp_add_list)) {
> +		/* there were errors, delete all mac in hw */
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
> +		/* VF does not support promiscuous mode, don't delete any other uc mac */
> +		if (!HINIC3_IS_VF(nic_dev->hwdev) || !uc) {
> +			list_for_each_entry_safe(f, ftmp, mac_filter_list,
> +						 list) {
> +				if (f->state != HINIC3_MAC_HW_SYNCED)
> +					continue;
> +
> +				fclone = hinic3_mac_filter_entry_clone(f);
> +				if (!fclone)
> +					break;
> +
> +				f->state = HINIC3_MAC_WAIT_HW_SYNC;
> +				list_add_tail(&fclone->list, &tmp_del_list);
> +			}
> +		}
> +
> +		hinic3_cleanup_filter_list(&tmp_add_list);
> +		hinic3_mac_filter_sync_hw(netdev, &tmp_del_list, &tmp_add_list);
> +
> +		/* need to enter promiscuous/allmulti mode */
> +		err = -ENOMEM;
> +		goto err_out;
> +	}

I'm under the impression that this code could be simpler if
hinic3_mac_filter_sync_hw() don't modifiy the argment lists, but set
some flag on the successfully added entries.

In case of failure, you traverse the tmp_add_list and delete all the
unflagged entries.

Both lists are always cleaned-up at function exit.

/P


