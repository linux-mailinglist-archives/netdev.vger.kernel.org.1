Return-Path: <netdev+bounces-231143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B4ABF5AD3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38722401CB5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE52EF66D;
	Tue, 21 Oct 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXuYgoaj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A62E9EB9
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040987; cv=none; b=aG0zmrdDyti7yJQLdgsxhwuXyLtayGk5fM77EBOLpuy9PvmbJs2pREANL9e65ddEJfyhrpNO97KgfAFBOmLHdeQqeXAgy9GcqCcJqhFDvlfu7t05zoe1LVOelInN/IyOJlsAYTTkDeqkadfOL1gDnfcUBi3EO7bY5UxMre2XfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040987; c=relaxed/simple;
	bh=4X3PCzTUi+t6U3Xb46bofkEjcpM45wzgycTZWdrLVKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQsLr+5/2Ipb/O2heAKFkcafo3fxWqSHDNr71O/Xvp0knmeQWmJzqXYOx2QmZQD9gNqzOc+GVKVkMMqjB0SF/5GHsqL5X1xx6/2ED0AEexR7cRxjJ2vxXJ9/uLeSBwuz4EHXwIs5Oohbi52Ngwo4vvGJvXLvnXxr/Us5mEXVXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXuYgoaj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761040984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh9VBIDeD1YW+winnmo1WNn0Q66KIhY7uXc+kNmNSe8=;
	b=cXuYgoajPhz83P9c1UQDrY6DeDB5bdiVpbybYPHO6tZ3Sb34l1Kz/1WT17DfVd2/jIB13I
	wURZENSc6ymmiOh7fUoNRzfQpuARjrCljnh6qM+Pyz1o9MaXkNOPnw+BqjwIH1E/x3G9z8
	6uBZ0hmfqqjycCDhhbb7qPilEG9ZWWM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-f0pReYQZNribh3cUxVdJvw-1; Tue, 21 Oct 2025 06:03:03 -0400
X-MC-Unique: f0pReYQZNribh3cUxVdJvw-1
X-Mimecast-MFC-AGG-ID: f0pReYQZNribh3cUxVdJvw_1761040982
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47108163eeaso26038405e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040982; x=1761645782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dh9VBIDeD1YW+winnmo1WNn0Q66KIhY7uXc+kNmNSe8=;
        b=em1oFzNop5M9/yssIW/Nqbkl66WIA98Uq9N3BgaT0j7FY/Ofd4B/3NTshDTr3bOLvn
         vXbFX9DLVToD/tp0KkTpm3cKuUsJRKrYOQTqxRzrdbcDxnydqq7Fgh/iCWf3QlOg52Na
         tBVUXA/e/dTZqojTdsJ+IYrhP7DzJb6TOoYaZOI4LzpIabk0y+yKOc05KZk0i6onxhBr
         ORUT8I1UfnGq6Uq5QBdzOplRDcwwog5zuCmDskITVpN6pUVX+HxYnV1ZwYAUer+917uK
         DBxvmsplPy+G4JkAjaqISQypjmDJs1PoPkF+iTSuLNvzjZ1xuvFqqOR2Xr78W3xliZva
         XDrA==
X-Forwarded-Encrypted: i=1; AJvYcCU2B+u4kEMSSR+DbgSaRk+tfUmkG6Uj4W8fk+H4spJVfVW5NeOWJfsdqO7ww3bKeWHDH0zXv4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0KzGU4Wh9OCR+imCJ3hQbvkIW6up/KR1u2IBujWYl6Q5H8Sh7
	5JJERcVmwnns/74k4iP6POFVEQpMNvhsNpKk5QyunKi+KpfkVU/9JiARyXF3b8ycr3OJ5e7JDrk
	IApQNNzLx/0ad6IBC0C2+jUO0IyoFDMHnOFixKdS7xhvLACzI1NjSG8EXIw==
X-Gm-Gg: ASbGnct+2rFio/puxAGpeXzg3zJGXg7lULwVkBT6PEjx+zTF3kko22lgbCDAYmuw1tH
	VkUYZLznu2HT6hAxXkj9xI/+QptPu45uERRBfNgzjGQglxTRp/y8lTcBipY8MQydKoXr/Vcs3pc
	R0pZPUt5zlnFhi9RXyTJAZHzlN4NdzdH/HxK5rFovdoMILJPQN9dSM+rmcjcjeF3OWkXo4uIrnK
	S8KNe2gJrAOARkRrFYWhv1UCPRCStzPteCJkzkW9vD9L0i/+eWxOp9sJ1mjJ+NAKfJ2a3aHfOMx
	GY1Il0cp3ypbM1y4t73ph1QYyYQDhS9n7nE/hs5ePPQ+yIIh/m8RjEtMb7zCQQ9jrEFNxTTF1wU
	02spGsFNoHG7DoPeaFg0jR8y9uuTWqdrPvvqPmMj2lM1Xk9s=
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-471178a236cmr113650945e9.10.1761040982364;
        Tue, 21 Oct 2025 03:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz0MIaxzEx8MqXNj7QakxLNajYTx+Vzevf5zqj7jjSvfZ+GyZLrKl3dgVva61Mp2iFS2TUNA==
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-471178a236cmr113650685e9.10.1761040981961;
        Tue, 21 Oct 2025 03:03:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471553f8a3asm218799785e9.16.2025.10.21.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:03:01 -0700 (PDT)
Message-ID: <465d5a38-abee-40b4-9026-aefaf47a943c@redhat.com>
Date: Tue, 21 Oct 2025 12:02:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 3/6] hinic3: Add NIC configuration ops
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
 <b5b92e0bdc2bd399c56ee356a7b6593f3ddf69c2.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b5b92e0bdc2bd399c56ee356a7b6593f3ddf69c2.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> @@ -368,12 +407,16 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
>  	netdev = nic_dev->netdev;
>  	unregister_netdev(netdev);
>  
> +	cancel_delayed_work_sync(&nic_dev->periodic_work);

periodic_work unconditionally reschedule itself, I think you shoudl use
disable_delayed_work_sync() here.

> +	destroy_workqueue(nic_dev->workq);
> +
>  	hinic3_update_nic_feature(nic_dev, 0);
>  	hinic3_set_nic_feature_to_hw(nic_dev);
>  	hinic3_sw_uninit(netdev);
>  
>  	hinic3_free_nic_io(nic_dev);
>  
> +	kfree(nic_dev->vlan_bitmap);
>  	free_netdev(netdev);
>  }

[...]> @@ -406,6 +418,8 @@ static void hinic3_vport_down(struct
net_device *netdev)
>  	netif_carrier_off(netdev);
>  	netif_tx_disable(netdev);
>  
> +	cancel_delayed_work_sync(&nic_dev->moderation_task);

Same here.

/P


