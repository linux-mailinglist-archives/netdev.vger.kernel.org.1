Return-Path: <netdev+bounces-275866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHf+D2mU1GknvgcAu9opvQ
	(envelope-from <netdev+bounces-275866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A73A9E1C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C8AE300F1BD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 05:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804734F255;
	Tue,  7 Apr 2026 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hufiygUT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFB337699
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539303; cv=none; b=KXF9tWDIs0JLW4M6ToFE2AvqJjM0Z/Q0sZt8XYC40mjdZ7p4lSw9a25RKz08lK68cyPRGXodRMMoyQ6ZMTDCBgKhf4MzaEHwLH2MqM55WjPP3PRprGRZ/m+oPXvujpDXikrlHWqT3dUm0LKMBf8DUfJkk27B5K9nBhIa3SwRNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539303; c=relaxed/simple;
	bh=J0khTmXx+mH8KMAAu7/0Jhz0WYYqPaYIpbG+MFI9hGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGL/6nUlq20YDl5mW5Dq0PNAJZx4ZgYbBrSO1P0bAaQWEpFxBjEBMUZFt1LWnyxV79AM34BCbSZ0Fou/GBGKC6XngqbAnr+YlpB0Gm5UVk2SFl9ZmD7cuQn+UulNsaTEV8y6zUq8qPBFpPMYS52Bp/Xu468KD5PboJNx+LQ4nPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hufiygUT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775539301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0khTmXx+mH8KMAAu7/0Jhz0WYYqPaYIpbG+MFI9hGs=;
	b=hufiygUTgjolz1in+RzAGQHTiFgw6SXJutVimBKciKaXZOaebl6qdhDRmMmbWz+tsHmdli
	l3RG1iGKncTjZySAsFtTP14sRAkpQWzPJJVQ8Hd3XzToeWyQDyRXsoxBm8p1SUiaOXOLDi
	GufNfmWheWqJjwiqAQI/GMtTaylOxww=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-8nzXMfqUMq6feDKfT0MdUQ-1; Tue,
 07 Apr 2026 01:21:36 -0400
X-MC-Unique: 8nzXMfqUMq6feDKfT0MdUQ-1
X-Mimecast-MFC-AGG-ID: 8nzXMfqUMq6feDKfT0MdUQ_1775539294
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3729218002CB;
	Tue,  7 Apr 2026 05:21:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8500300019F;
	Tue,  7 Apr 2026 05:21:29 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kohei@enjuk.jp
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/3] iavf: drop netdev lock while waiting for MAC change completion
Date: Tue,  7 Apr 2026 07:21:28 +0200
Message-ID: <20260407052128.207856-1-jtornosm@redhat.com>
In-Reply-To: <adOjGCms-5PBuNte@x1>
References: <adOjGCms-5PBuNte@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA3A73A9E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kohei,

Thank you for your help and reference.
I will try to do it synchronously with the netdev lock held as you say.

Best regards
Jose Ignacio


