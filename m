Return-Path: <netdev+bounces-200376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043FAAE4B8A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163763B223B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F067288527;
	Mon, 23 Jun 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8WYWxBd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E811B4242
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698120; cv=none; b=GxjthC6sFFS9fCDCjchMcYLIEXDTzcQyYnmG3lvlLYwqzNVjqjp4E8H5Zrucm6xYKTW8okp3qyDhFr06eQ625IP+m55YmL+V2ahFi1+IqtayYtyoFD3ggegj4MzE9wD1oGhKZjCOUHHSw0oOgQCopkvHFbzT6fDHKlj8Yw2vCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698120; c=relaxed/simple;
	bh=taqM6M2yCTAkigZXwCzc8+OLPoroFfNThxW7WCtpr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP7R9v8uNYTRTbtnz2cgD8Tuk7Albp9T5LMt3HmrPX+iqsUivJp/4xlsDbIvv/2iW9rn0FwxuniO4t0feRtGM5qWlm4jkOb0EflNwfSnXLledDBfZ42ATegn9uKmaffOlnCTZqynLfni1Bq/8tQTdHgH5OED+C5CnAKxI+TlfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8WYWxBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750698117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq5JtTNSTi3UbB2t2zf1v906mYuPWMRbjCVCINzsyvo=;
	b=A8WYWxBdy29vv8/Oidor6rBX1H+24AHKQp/1w2EzATLVn6OoHvA/fiA+6ww0knaLqm2ClH
	4oMDytUpNyGuqB2rJEU3jIyVMiLwtU6pODm2aou+yGp5Ghz43yheVFqNJeLYqbI5V6OeWy
	3NgCqGkwX6rKvsGPHCFKzgMUKrVUemA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-gUCd64CdOIGSuB1hIGKRyg-1; Mon, 23 Jun 2025 13:01:56 -0400
X-MC-Unique: gUCd64CdOIGSuB1hIGKRyg-1
X-Mimecast-MFC-AGG-ID: gUCd64CdOIGSuB1hIGKRyg_1750698115
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so1103764f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750698115; x=1751302915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5JtTNSTi3UbB2t2zf1v906mYuPWMRbjCVCINzsyvo=;
        b=EHScSn9c/YcW0SNJscPlfEIvafkCvOpCBKjVB+tsZalJ53QSQMfHJA6sItSEAzbihX
         YCplf2lyoCUd2n+h4LBeXh3FG688X8r56QQDY2w3WMJ8mQYx+/XbDawm9IIIDaJ3L9bf
         vrUd5INzt5HO4TXYc8ynxEsF8aA+cRZN6FMcnyvpJAkFZlkQuEl6vni0oKueUzVcs2iJ
         BQx/ET8HGGaB36r3FYxG8Mppvslrti4zX9KPBx/fJkPBQv5aMoDDjWuy/16wbCb+8069
         FkzG0+Uuf85wPZJHeGubVs5eM25q5CBE9NKtzPh8BlBY6jG6/Mn17UFZgTTljvKef1IB
         3dww==
X-Forwarded-Encrypted: i=1; AJvYcCUZlv5OoHsYBehszMviu9j0nGO2jKU0OYa/S8Z0y1UOytBBe2oMMRBNbGZDOj6PurFZUu47V5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM88gGmqMMGujHNlcHq1OT3tZxnVn0yyJDcIptGQQbC6Cjy2Vv
	On1IGEyX9i+kwLDayK9p90t5BlnJQ+EM55Px1p0v7YdECdbT9G5AkzyCyvsz1fuajKGUfrXZ1Nk
	cZMclCbImHNa3/OZjALFUBKGB576dHvnJ9HO+w6OMPJZV/Q9YSHw9oMcFJw==
X-Gm-Gg: ASbGnctEHV66SQBhS4/UdgyRjKNIkVDKLEvqGn0Q7v8wPPeauAEGw6rz4MkrBweev59
	P+lRsl0WZLb+1hd6xMO3LlDZFDls8DG0bm+7fXfClBFxUiZFSfvlEanp799h7o3khBceZOBDfTu
	qNudlGk4xC3QwPnPaDW3kE4YGkbB5PSZFqWYEfl1Tfv2/4CxZrkb1uTAg3iP5a8eUBGvDFfz7P8
	JowRl1/f89tf0vujZeB31u+hmSutduob4TgEjzkedVMj5MNIlTGQbKqKgNfb/HxkSv/rd4+L7iE
	Q+e6VGKwz/OrWEaFyrNNSEM50MY=
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr11150054f8f.51.1750698114884;
        Mon, 23 Jun 2025 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgLc1G5fHA+5OCdohy+RX20t3SZJ3zi/U76KcD2RoeCTL1jtFDfjcLkndhINDFJCXPqEyFPQ==
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr11149981f8f.51.1750698114073;
        Mon, 23 Jun 2025 10:01:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10411sm9667235f8f.1.2025.06.23.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:01:53 -0700 (PDT)
Date: Mon, 23 Jun 2025 19:01:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	haiyangz@microsoft.com, jasowang@redhat.com, kvm@vger.kernel.org, kys@microsoft.com, 
	leonardi@redhat.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev, 
	wei.liu@kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <opt6smgzc7evwrme7mulwyqute6enx2hq2vjfjksroz2gzzeir@sy6be73mwnsu>
References: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
 <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>

On Sun, Jun 22, 2025 at 09:59:10PM +0800, Xuewei Niu wrote:
>> ACCin hyper-v maintainers and list since I have a question about hyperv
>> transport.
>>
>> On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
>> >Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>> >socket. The value is obtained from `vsock_stream_has_data()`.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
>> > 1 file changed, 22 insertions(+)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 2e7a3034e965..bae6b89bb5fb 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>> > 	vsk = vsock_sk(sk);
>> >
>> > 	switch (cmd) {
>> >+	case SIOCINQ: {
>> >+		ssize_t n_bytes;
>> >+
>> >+		if (!vsk->transport) {
>> >+			ret = -EOPNOTSUPP;
>> >+			break;
>> >+		}
>> >+
>> >+		if (sock_type_connectible(sk->sk_type) &&
>> >+		    sk->sk_state == TCP_LISTEN) {
>> >+			ret = -EINVAL;
>> >+			break;
>> >+		}
>> >+
>> >+		n_bytes = vsock_stream_has_data(vsk);
>>
>> Now looks better to me, I just checked transports: vmci and virtio/vhost
>> returns what we want, but for hyperv we have:
>>
>> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> 	{
>> 		struct hvsock *hvs = vsk->trans;
>> 		s64 ret;
>>
>> 		if (hvs->recv_data_len > 0)
>> 			return 1;
>>
>> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
>> Do you think we can do that to support this new feature?
>
>Hi Hyper-v maintainers, could you please take a look at this?
>
>Hi Stefano, if no response, can I fix this issue in the next version?

Yep, but let's wait a little bit more.

In that case, please do it in a separate patch (same series is fine) 
that we can easily revert/fix if they will find issues later.

Thanks,
Stefano

>
>Thanks,
>Xuewei
>
>> Thanks,
>> Stefano
>>
>> >+		if (n_bytes < 0) {
>> >+			ret = n_bytes;
>> >+			break;
>> >+		}
>> >+		ret = put_user(n_bytes, arg);
>> >+		break;
>> >+	}
>> > 	case SIOCOUTQ: {
>> > 		ssize_t n_bytes;
>> >
>> >--
>> >2.34.1
>> >
>


