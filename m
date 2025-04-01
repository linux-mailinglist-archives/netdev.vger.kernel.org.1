Return-Path: <netdev+bounces-178516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA58A776CE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173793A8F2D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FC1EB5C9;
	Tue,  1 Apr 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cTe3H2/z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cTe3H2/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFD79C0
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497274; cv=none; b=ZP3eQv23r/WW04meU5uxYUVJLhNEtl9QE9Q/Qh4ETcvDIwZRcb1oXV8X8IpJAEmvB7SMLNpj6sSnpo8k7pg/U/gWa8eqokVOUTP88Aqjag9erCJ51VjBMByTKg7GngxBI+6cvkP2U8S3Chy+gQioBm6Maq0DX2cBplAdmYFyGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497274; c=relaxed/simple;
	bh=xQBIVbpmVUWrYaXxtQbX8UTUDAhT+C6Kszgm8v/ZAHA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QgOjrOkt9Ak7GtKtkW1ppDmJcwj4fx0ylmVZLZM7zb7SADK+YFcrmYpypqaDH1PwByRh+eY1Z4eA/u9ygsZHw1ZppeUn/3uiHjEvzQ5VMb1yamc/mqqN6bL0Bgxas2r7SGKxvm5CH1Yo3oFWwr+XGFYGsqqS6PzApmzYQ75mn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cTe3H2/z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cTe3H2/z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07431211DD;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xQBIVbpmVUWrYaXxtQbX8UTUDAhT+C6Kszgm8v/ZAHA=;
	b=cTe3H2/zamcxc2ZtiHKzcfbj0LxQ1nqdUMoOTWX/sxxl/YpB7UCGnAj5iGlGV1wGjb8tDf
	rujjo0BtYkTgaY1m+ag0Bb4BOn1q8KjG+G+q5q31+FQ7+1WrSVjZ9Aj7OX7G/zns7oI5fz
	bqG9LiZMfWQ0EjlkRQFa4GUbIMRHVJ4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xQBIVbpmVUWrYaXxtQbX8UTUDAhT+C6Kszgm8v/ZAHA=;
	b=cTe3H2/zamcxc2ZtiHKzcfbj0LxQ1nqdUMoOTWX/sxxl/YpB7UCGnAj5iGlGV1wGjb8tDf
	rujjo0BtYkTgaY1m+ag0Bb4BOn1q8KjG+G+q5q31+FQ7+1WrSVjZ9Aj7OX7G/zns7oI5fz
	bqG9LiZMfWQ0EjlkRQFa4GUbIMRHVJ4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C98EE13691;
	Tue,  1 Apr 2025 08:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OuIRMDao62cRcQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 01 Apr 2025 08:47:50 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCHv2 0/4] USB: wdm: fix WWAN integration issue 
Date: Tue,  1 Apr 2025 10:45:37 +0200
Message-ID: <20250401084749.175246-1-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.96 / 50.00];
	BAYES_HAM(-2.66)[98.52%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.96
X-Spam-Flag: NO

The original integration of WWAN left a few race conditions
and deficiencies in error handling

V2: Added memory barriers Alan Stern pointed out the need for

