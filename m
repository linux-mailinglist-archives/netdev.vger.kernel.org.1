Return-Path: <netdev+bounces-245698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9109ECD5D80
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AA8E3015767
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E431B107;
	Mon, 22 Dec 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2zMOafh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcXpt6J+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EF31A7F6
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404101; cv=none; b=XGBMNHBxpb8JUtV0W4H5v+Can7bkWzUEXDXkQjK1STfprW24y+fNQ1YgBnSdIGqVMHgp0Neb/moWgx5qbTT2AEXipG7AZenzvb8rDg7nFaJNCOJNXm0N7BNPbvbj3pWAly7DWLN66NyGWWkJEHUnMCnXEbhYEFyeETBserRHnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404101; c=relaxed/simple;
	bh=lYuLP9aLBqUlpP+urfkQzNeqIQUc+NMj+DtIqhGgHuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgM/MHnGPP5m6Fg4m4BeQcw9Q+GD7kMRqJfTEkr9EQBHap0YU2U7fzVIOPQkUUHRldYdQS3+tMM+/0+MNoEj4punhbpbPhw43uqbaGLaorme7n+sOo+KOtgmBoDzOyQbiyYbQBxhMtvlS8zmOx8LvGcSUChgIlqU0uj3hayb4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2zMOafh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcXpt6J+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766404098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OThu/IjAGzkBq+quJ/q8oM4R3JgY1MkWRoPROf/868=;
	b=h2zMOafhSBS7dNcfXcVZSr/csE187+awzbXW/rNl/PQ+XAyQHRh1nTqYEnZgvk3/QGI7gN
	m6MRkw3XBvB75crwIoFaVURztPjEJJGEtgI5uRn2P/If1HAHmoo3HqFqrlvr7NrFBO+fTi
	BnFIzVb4X/5GY/HxqmpMCjutOI52U7Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-tYOYE5OrO1mrzLEHYYQ5-A-1; Mon, 22 Dec 2025 06:48:16 -0500
X-MC-Unique: tYOYE5OrO1mrzLEHYYQ5-A-1
X-Mimecast-MFC-AGG-ID: tYOYE5OrO1mrzLEHYYQ5-A_1766404096
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so28152655e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766404096; x=1767008896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OThu/IjAGzkBq+quJ/q8oM4R3JgY1MkWRoPROf/868=;
        b=KcXpt6J+SH2JEd02GpQnONOXAPKKleQtqc0k+06N/hKHJj7W+xakWc/YOxaGEF+Yay
         ncPAlBoAltso9V81i0/BQN47TVtvwwTXlEY4Pz0oS7WELECXpbvDmaGgMVEIcJl4VxPN
         7R5AW3FLLKYOjomsAJ+H7FL9SXXa8syrFdBAF6i8QhEFb56u4NCIkSKUyYuur76RRua8
         ejV+jBe6R8kaRVB5uClBpgWaCM1XB2gwcQLu6W+Ra67FHhHMRJVNkHuzLPVBLq6lIaj/
         3mvw+9Fmbei/sBYCbmF2yLteFU+1s1jiKoycpqHCvfvsElM1ETySzaeorNJIwKgUfWyY
         a6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404096; x=1767008896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OThu/IjAGzkBq+quJ/q8oM4R3JgY1MkWRoPROf/868=;
        b=cii3yIDjCqVgDv7/5381CkiFliIMeRfvm+gRn/ulz9gH8JEfWbZ+MwpOXPQbqKk3/0
         Freg03MeKNRSFjIf4WRGG/AL2T1TOqQhMQQ50uH/F04wbGxebre4/PD03QILr/5Iww2X
         7GLuETJIi3W6RwonmtEbF9/d3PySnvz7Kdo2+F1Ymv1rGjyKG4Xlz3EVesZEL85XKZxQ
         1LjoLHEX4tOR50foDWt/c1ZZpLj8iDRahs15qQO2mDq50/m/+q87iF3oPM8VB4TqrR1k
         ADW8EaxNcmvtGOpPaBnUxu3XOLHNizyBoNHMaX5I/zqSBCelHKq0O3Kqxbajh508dhjb
         Z/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPYBWHKWe2bvjl/7JGpznByrloQkMmOI/lHM3MhoO3rsca5QRY4w3iXLcpnoNrzDbxc4Ksxnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hsIrxLeG+JHN7ldQMWE6liFOcF0GsUk5tf/XIiHPuXFHeWzG
	396sn6JvMgYDpUzoptRTcCA6pIjYAti3A3LhSKRAoun44jJOA8kfMNX747wMfJGjhnH9WMact8G
	cInkKrvjga85oUOnCOqoIU9uUqgfNJZ2tCROxQvelDxLzwBv/GIsHncdDTw==
X-Gm-Gg: AY/fxX4+ag+iMck/1C1MYoT8ESpQUYjDPoVJKRSrK8XKBxMKqT72BqEAPJZ1Stjg9pi
	wK988LZqjA1Cw7VM9MTf37Sz0bseiWRoZ5TpCBAvBxiUio436eXmge+hyPhvsKgh9FAwYAMOvRZ
	OdYwtbM/s2yoCNdWILzynpLKdAnC7FGUtPErIxvdd/FowC0FWq8cXP/W5PNaQAbsyHK7awiJyT9
	yvVvLNq8Gl0hy1z/4aZLOtSxasz4KWUzR9hTJoEHkDMJkw0Wcsonc4tFHvkmnZPDHCWehPN0qlE
	bpHTgyHAQIa+TOniqhHeislqhFBQlbcGzdsnaHq1BwHQqPPAQiqjex4knE5qxJBgFDklruwy7Xe
	MZOpn0scsCV3n
X-Received: by 2002:a05:600c:1d1d:b0:479:1348:c61e with SMTP id 5b1f17b1804b1-47d1957d746mr102206345e9.20.1766404095689;
        Mon, 22 Dec 2025 03:48:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXcVpJ9XpL3tNS1cQvFyqPl/3DvxNFYL21GwwhDXV+oXv+RLFBPB9kKJPW2oylc2cqKXev9g==
X-Received: by 2002:a05:600c:1d1d:b0:479:1348:c61e with SMTP id 5b1f17b1804b1-47d1957d746mr102206145e9.20.1766404095316;
        Mon, 22 Dec 2025 03:48:15 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm21330135f8f.40.2025.12.22.03.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:48:14 -0800 (PST)
Message-ID: <2ce23c9d-f348-45ce-a2e2-583c45b0fc31@redhat.com>
Date: Mon, 22 Dec 2025 12:48:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251219202957.2309698-1-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219202957.2309698-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 9:29 PM, Mina Almasry wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

@YiFei and Mina: I believe this patch should go first via the intel
tree: please replace the 'net-next' tag prefix with 'iwl-next' on later
revision, if any.

Thanks,

Paolo


