Return-Path: <netdev+bounces-189970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ACFAB4A55
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299DC19E77AF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF821DE8AF;
	Tue, 13 May 2025 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="j9GxJcQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6D199230
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747109024; cv=none; b=GnTaMf6zTeL4RKP2SFQy3pEzfIIYTraVtmnjur5RfFDt0bwdkJ5hP3JJ/z2vqH/F/6GAgkKDJVc/lu5aA6abBgIsAu5nbXY+gN3Fb77BOTluANfpb+QkNp56sruSdDlSP/2T70C1n8yFGQ9ZvQg1zxJRs6NcxeHoDXePs4OX0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747109024; c=relaxed/simple;
	bh=SUCUcWhEf6oURpMI4/48jK9U0rgf4uvSgUfzkevEIZU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=AfeF/otv/az8o2+CkY+s/EhHb4GhwGBUgWXV5BxuUb0oHycwatOg+42okLEfraLv9zy0OEJhatQw9SUPtkIYC8tTLCtGTotIn6UpOg6FJE+zDujtOikw0OlmdjWZM7pOnFCXiYtQBe9BXrKw+xBwTfWcHOf70yXiwZolJvmYg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=j9GxJcQW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so3334526b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1747109022; x=1747713822; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzB3RQAsADcI31qVz9GqQrs/q8/eBx88YSQARAhtFs=;
        b=j9GxJcQWW4smzCDkZrncfoOzpLhL+nyhl9LYdwHUjePGo0zOcDikAn9oLgG103muN8
         ZthRnfKjaBmpDjOzjdoQfDdS5jjL9Wb01rRPrGxunG4ruGam5P7vxSN2Ct8O44zX8PvE
         fE+NhvKWfBrEh9Okm97hOW80tMFO4Es+pAjb13bvU3tjgf1dngLpU2BPMZgvCtBhW/gA
         0dRNYEgYqsw0e09l95fcIM0tHtKw+r1ClGaeFLzQVdKWZ1ujmS4FpGfQNpYJCzqvU4xb
         ssTVQDEeV5+u178zijqWfdR0w09JozCwpd+dEC2JZdEyvuTV74WnAPOuEUQQbLQwy2AR
         T6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747109022; x=1747713822;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzzB3RQAsADcI31qVz9GqQrs/q8/eBx88YSQARAhtFs=;
        b=NuD2aOP6HW44PPQl6v1YXf4B27g2tbNpATziGB1WvF9yzMAUOYRZtkdJCo1QoiFn4A
         x/rXG3J8L9LwzYt8HKSpy9SZlqUtHG6mUlkD3sIzyGQAZFuiUXuH5XIb3TooQgYEkQlZ
         6/Bg0XSnfJGOTnHA3LjchttxdCXNSl4ghAGWc6rWav7nQRx7Jh/bFiZb5WH3cco/iiBe
         ce07iiQLP5mWm6s7HFf721D1d5owGfqov+ll5Ggjed8FqUctaJwU4FNCy/i1cJDPFWNN
         G5wywCfBViIYrp0Qk9QOxLVwu1e8qqU1s/MMGfXIkD0UvJwmq3YUxN0f3Z7N/GSZj0Ql
         nQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUog9FAqMB4/s03O3dUeKm2AGh6snerOrgOHclThBcEewtn+szI+ldIrGg5V0crp+YBRtwcwZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFspfsh4mjmmzhaa3pejXlXEmcFgdU2TuXCzi5k1ZyUnAYOXMY
	MmaE+vP7FuF4msDUp/bVM423AirR7YE6gP3VaRtt905W/pvCFmX9QQBgv0YdVhk=
X-Gm-Gg: ASbGnctE4zyDRFUsLDbcyk9/Tt1ZiU3gMz2nxf5vuJB91bVPAKLzfj4ZBJmRvzMiFa4
	R0MRD4jyH3GzcSlVp2SAh5n5GCUBiU6VdSImMOPD7Kh5ghywteypJOT6q0s+xKAoqiyzoOcy8dh
	/+2ZA/diQOEcZ2BImtecBzVXmzy4/5d9AfQkvG9o4keoPvF+6l+HWdi6sYvdqo+apPCxLtOEVI4
	TkX7D7QfFFFalmM29vlUlaTLE6myA9Len1XljixcCMmiXP4l71WpBnn41UBSjyxfmB4AgvYNYs5
	wtzEk1pUdBdGGpvx0lnb3RTqdxEE8ULbUj6mjE0z74MxlSVXlmxxVuMuQtjwiLLl
X-Google-Smtp-Source: AGHT+IE6FehQ0Pj2VSk9mpLd2SRg9MECNcebEAawn/KZn7HTf7AREaTP1HNWEQRmjJgttvr6iHqtPA==
X-Received: by 2002:a05:6a21:3292:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-215abb4f8f6mr21761065637.4.1747109022091;
        Mon, 12 May 2025 21:03:42 -0700 (PDT)
Received: from [10.54.24.77] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772750bsm6819207b3a.42.2025.05.12.21.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 21:03:41 -0700 (PDT)
Message-ID: <0c8bf3f2-1620-420e-8858-fe1c2ff5a8e9@shopee.com>
Date: Tue, 13 May 2025 12:03:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Haifeng Xu <haifeng.xu@shopee.com>
Subject: i40e: How the packets will be processed when status_error_len is 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

	If the packets arrive at the rx and then raise soft irq to handle it, but in i40e_clean_rx_irq, status_error_len is 0 and return.
	The data isn't fetchted from the rx buffer, so the how the packets arrive at the rx will be processed?
	
	FYI, the every rx/tx queue has been bounded to one cpu(64 queues, 64 cpus).

Thanks!

