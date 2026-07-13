Return-Path: <netdev+bounces-307057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V2BDMpacVGr4oAMAu9opvQ
	(envelope-from <netdev+bounces-307057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:06:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73D7487E7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:06:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="H VcHVJK";
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307057-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307057-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DBEB30053FB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F736897C;
	Mon, 13 Jul 2026 08:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868B3955EF
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:04:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929883; cv=none; b=tqejT+xKLTeZYBkCg5WfQY4ryhmF6NAc6q9z3bQj6XvRyBT7KeezPPk85phloFBcW6NJADGMQEEy8tVtFnUuUXz3CVxndBq+Q6m22XWCHUvV7NylEJn78W8su7apIhYTMsTShycUQdcjHv7Wf6KJn7TiVPwxHIEtTEw7FOE3ur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929883; c=relaxed/simple;
	bh=kVRP38ALCF4QqtzJICmTItLqiMqqfw345qhv/RBjOGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=u5LKKl0gJmpwaIHwlJ42Azdca+yQIWtaxzVwNoSnQfdIih19R1DEeTJY40htwddNd1NhT68QSZY8lMKMIRidDOA3IUYW78AryVV7qK47cYvdQohegRsY12vm3vK0zxT4AdYefjAij9SXoFQ8VTWk2uCjQXrcjYzv7FdVPEt2hAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HVcHVJK0; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kVRP38ALCF4QqtzJICmTItLqiMqqfw345qhv/RBjOGk=; b=H
	VcHVJK0ZUlQH4j8TZ+aDdnvSVWSTf0dHRoakkLnVh7d8u0lZF3dD2duKH8e92yx5
	bXP+pMRahyt5bnWw0qhbIpJc27ENeOB1FDr2KyGymv/nbpaHpmfbSyDWkuflx+90
	UIhjK7rJxF2C1uDojmHA9ypZs4drCi6zZGPZPHTahM=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Mon, 13 Jul 2026 16:04:14 +0800
 (CST)
Date: Mon, 13 Jul 2026 16:04:14 +0800 (CST)
From: "Xiong Weimin" <15927021679@163.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xiongweimin <xiongweimin@kylinos.cn>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re:Re: [PATCH] vhost/net: Fill virtio_net_hdr GSO/csum metadata on
 RX
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260713025549-mutt-send-email-mst@kernel.org>
References: <20260713010442.331109-1-15927021679@163.com>
 <20260713025549-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2TAfWZtkAu4imaY+kckk8Ugeg8Xsewsvgh249ec/8Eti30+AcGdm9jI0vR8sOpOxyGjSi2UTVlzvhfT4N1sOqLki8PQQvYTU36kvOrvQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4bb48033.666a.19f5a815bd7.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dygvCgD3393_m1RqeMYcAA--.7291W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0R7VXmpUm-7lFwAA3t
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xiongweimin@kylinos.cn,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307057-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C73D7487E7

CgoKSGkgTWljaGFlbCwKCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgoKT24gd2h5IFZIT1NUX05F
VF9GX1ZJUlRJT19ORVRfSERSOgoKCldlIGhpdCB0aGlzIHdpdGggdmhvc3QtdXNlciBiYWNrZW5k
cyB0aGF0IGRvIG5vdCBleHBvc2UgSUZGX1ZORVRfSERSCihlLmcuIERQREsvY3VzdG9tIHNvY2tl
dCBiYWNrZW5kcykuIFdoZW4gdGhlIGd1ZXN0IG5lZ290aWF0ZXMKVkhPU1RfTkVUX0ZfVklSVElP
X05FVF9IRFIsIHZob3N0IGlzIHJlc3BvbnNpYmxlIGZvciBzdXBwbHlpbmcKdmlydGlvX25ldF9o
ZHIgb24gUlguIFRoZSBjdXJyZW50IGNvZGUgYWx3YXlzIHplcm9lcyB0aGUgaGVhZGVyCihHU09f
Tk9ORSksIHNvIGd1ZXN0cyB0aGF0IG5lZ290aWF0ZWQgR1VFU1RfVFNPKi9HVUVTVF9DU1VNIG5l
dmVyCnJlY2VpdmUgY29ycmVjdCBvZmZsb2FkIG1ldGFkYXRhIGV2ZW4gd2hlbiB0aGUgc29ja2V0
IHNrYiBoYXMgaXQuCgoKVGhlIGdvYWwgaXMgdG8gbWFrZSBSWCBvZmZsb2FkIG1ldGFkYXRhIGNv
cnJlY3QgZm9yIHRoYXQgY29uZmlndXJhdGlvbi4KVFggVFNPIGlzIGludGVudGlvbmFsbHkgbGVm
dCBmb3IgYSBmb2xsb3ctdXAgc2VyaWVzLgoKCk9uIHRoZSByYWNlIHlvdSBwb2ludGVkIG91dDoK
CgpZb3UncmUgcmlnaHQg4oCUIHBlZWtpbmcgdGhlIHNrYiB1bmRlciBza19yZWNlaXZlX3F1ZXVl
LmxvY2sgYW5kIHRoZW4KYnVpbGRpbmcgdGhlIGhlYWRlciBhZnRlciBkcm9wcGluZyB0aGUgbG9j
ayBpcyByYWN5IGlmIGFub3RoZXIgY29udGV4dApjYW4gZGVxdWV1ZSB0aGUgc2tiIGJlZm9yZSBy
ZWN2bXNnKCkgcnVucy4gSSBzZWUgd2h5IHRoZSBoZWFkZXIgZmlsbGluZwplbmRlZCB1cCBpbiB0
dW4sIHdoZXJlIHRoZSBiYWNrZW5kIG93bnMgdGhlIHNrYiBsaWZlY3ljbGUuCgoKSSBjYW4gdGhp
bmsgb2YgYSBmZXcgb3B0aW9uczoKwqAgYSkgRHJvcCB0aGlzIGFwcHJvYWNoIGFuZCBub3QgdXNl
IFZIT1NUX05FVF9GX1ZJUlRJT19ORVRfSERSIGZvcgrCoCDCoCDCoHRoZXNlIGJhY2tlbmRzIChr
ZWVwIHplcm9lZCBoZWFkZXJzIC8gbm8gZ3Vlc3Qgb2ZmbG9hZCkuCsKgIGIpIE1vdmUgdGhlIG1l
dGFkYXRhIGV4dHJhY3Rpb24gdG8gdGhlIGJhY2tlbmQgKHNpbWlsYXIgdG8gdHVuKS4KwqAgYykg
SG9sZCB0aGUgcmVjZWl2ZS1xdWV1ZSBsb2NrIGFjcm9zcyBwZWVrICsgcmVjdm1zZyBpZiB0aGF0
IGlzCsKgIMKgIMKgYWNjZXB0YWJsZSBmb3IgdGhpcyBwYXRoIChJIG5lZWQgdG8gY2hlY2sgd2hl
dGhlciByZWN2bXNnIGNhbgrCoCDCoCDCoGJlIGNhbGxlZCB1bmRlciB0aGF0IGxvY2spLgoKCkNv
dWxkIHlvdSBzdWdnZXN0IHdoaWNoIGRpcmVjdGlvbiB5b3UnZCBwcmVmZXI/IEknbSBoYXBweSB0
byByZXNwaW4Kb25jZSB3ZSBhZ3JlZSBvbiB0aGUgcmlnaHQgaW50ZWdyYXRpb24gcG9pbnQuCgoK
SSdsbCBhbHNvIGZpeCB0aGUgbXVsdGlsaW5lIGNvbW1lbnQgdG8gZm9sbG93IHRoZSBuZXQgY29u
dmVudGlvbjoKCgovKiBXaGVuIFZIT1NUX05FVF9GX1ZJUlRJT19ORVRfSERSIGlzIHNldCwgdmhv
c3Qgc3VwcGxpZXMgdmlydGlvX25ldF9oZHIuCsKgKiBQb3B1bGF0ZSBHU08vY2hlY2tzdW0gbWV0
YWRhdGEgZnJvbSB0aGUgc29ja2V0IHNrYiAuLi4KwqAqLwoKClRoYW5rcywKV2VpbWluCgpBdCAy
MDI2LTA3LTEzIDE1OjAzOjM5LCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+
IHdyb3RlOgo+T24gTW9uLCBKdWwgMTMsIDIwMjYgYXQgMDk6MDQ6NDJBTSArMDgwMCwgd2VpbWlu
IHhpb25nIHdyb3RlOgo+PiBGcm9tOiB4aW9uZ3dlaW1pbiA8eGlvbmd3ZWltaW5Aa3lsaW5vcy5j
bj4KPj4gCj4+IFdoZW4gVkhPU1RfTkVUX0ZfVklSVElPX05FVF9IRFIgaXMgc2V0LCB2aG9zdCBz
dXBwbGllcyB2aXJ0aW9fbmV0X2hkciB0bwo+PiB0aGUgZ3Vlc3QgYnV0IHByZXZpb3VzbHkgYWx3
YXlzIHdyb3RlIGEgemVyb2VkIGhlYWRlciAoR1NPX05PTkUpLiBHdWVzdHMKPj4gdGhhdCByZWx5
IG9uIEdVRVNUX1RTTyovR1VFU1RfQ1NVTSB0aGVyZWZvcmUgbmV2ZXIgc2F3IG9mZmxvYWQgbWV0
YWRhdGEuCj4KPlJpZ2h0LiBRdWVzdGlvbiBpcyB3aHkgYXJlIHlvdSB1c2luZyBWSE9TVF9ORVRf
Rl9WSVJUSU9fTkVUX0hEUj8KPgo+PiAKPj4gUGVlayB0aGUgc29ja2V0IHNrYiBiZWZvcmUgcmVj
dm1zZyBhbmQgcG9wdWxhdGUgdGhlIGhlYWRlciB3aXRoCj4+IHZpcnRpb19uZXRfaGRyX2Zyb21f
c2tiKCkuIEFsc28gYWR2ZXJ0aXNlIHRoZSBjb3JyZXNwb25kaW5nIGd1ZXN0IG9mZmxvYWQKPj4g
ZmVhdHVyZSBiaXRzIGZyb20gVkhPU1RfR0VUX0ZFQVRVUkVTLgo+PiAKPj4gVFggVFNPIHRvd2Fy
ZCBiYWNrZW5kcyB3aXRob3V0IElGRl9WTkVUX0hEUiBpcyBpbnRlbnRpb25hbGx5IGxlZnQgZm9y
IGEKPj4gZm9sbG93LXVwIHNlcmllcy4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IHhpb25nd2VpbWlu
IDx4aW9uZ3dlaW1pbkBreWxpbm9zLmNuPgo+PiBDYzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4KPj4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IENj
OiB2aXJ0dWFsaXphdGlvbkB2Z2VyLmtlcm5lbC5vcmcKPj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmcKPj4gLS0tCj4+IAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L25ldC5jCj4+ICsrKyBiL2Ry
aXZlcnMvdmhvc3QvbmV0LmMKPj4gQEAgLTczLDYgKzczLDEwIEBACj4+ICAJVkhPU1RfRkVBVFVS
RVMsCj4+ICAJVkhPU1RfTkVUX0ZfVklSVElPX05FVF9IRFIsCj4+ICAJVklSVElPX05FVF9GX01S
R19SWEJVRiwKPj4gKwlWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSwKPj4gKwlWSVJUSU9fTkVUX0Zf
R1VFU1RfVFNPNCwKPj4gKwlWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNiwKPj4gKwlWSVJUSU9fTkVU
X0ZfR1VFU1RfRUNOLAo+PiAgCVZJUlRJT19GX0FDQ0VTU19QTEFURk9STSwKPj4gIAlWSVJUSU9f
Rl9SSU5HX1JFU0VULAo+PiAgCVZJUlRJT19GX0lOX09SREVSLAo+PiBAQCAtNjQ0LDcgKzY0OCw3
IEBACj4+ICBzdGF0aWMgc2l6ZV90IGluaXRfaW92X2l0ZXIoc3RydWN0IHZob3N0X3ZpcnRxdWV1
ZSAqdnEsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKPj4gIAkJCSAgICBzaXplX3QgaGRyX3NpemUs
IGludCBvdXQpCj4+ICB7Cj4+IC0JLyogU2tpcCBoZWFkZXIuIFRPRE86IHN1cHBvcnQgVFNPLiAq
Lwo+PiArCS8qIFNraXAgZ3Vlc3QgdmlydGlvX25ldF9oZHI7IFRYIFRTTyBoYW5kbGVkIGluIGEg
Zm9sbG93LXVwLiAqLwo+PiAgCXNpemVfdCBsZW4gPSBpb3ZfbGVuZ3RoKHZxLT5pb3YsIG91dCk7
Cj4+ICAKPj4gIAlpb3ZfaXRlcl9pbml0KGl0ZXIsIElURVJfU09VUkNFLCB2cS0+aW92LCBvdXQs
IGxlbik7Cj4+IEBAIC0xMDI1LDYgKzEwMjksMzUgQEAKPj4gIAlyZXR1cm4gbGVuOwo+PiAgfQo+
PiAgCj4+ICsvKgo+PiArICogV2hlbiBWSE9TVF9ORVRfRl9WSVJUSU9fTkVUX0hEUiBpcyBzZXQs
IHZob3N0IHN1cHBsaWVzIHZpcnRpb19uZXRfaGRyLgo+PiArICogUG9wdWxhdGUgR1NPL2NoZWNr
c3VtIG1ldGFkYXRhIGZyb20gdGhlIHNvY2tldCBza2Igc28gZ3Vlc3RzIHRoYXQKPj4gKyAqIG5l
Z290aWF0ZWQgR1VFU1RfVFNPKi9HVUVTVF9DU1VNIHJlY2VpdmUgY29ycmVjdCBvZmZsb2FkIGlu
Zm9ybWF0aW9uLgo+PiArICovCj4KPnRoaXMgaXMgYSB3cm9uZyB0eXBlIG9mIG11bHRpbGluZSBj
b21tZW50LiB0aGlzIGZpbGUgZm9sbG93cyBuZXQKPmNvbnZlbnRpb246Cj4KPi8qIEFBQQo+ICog
QkJCCj4gKi8KPgo+PiArc3RhdGljIGludCB2aG9zdF9uZXRfaGRyX2Zyb21fc29jayhzdHJ1Y3Qg
dmhvc3RfdmlydHF1ZXVlICp2cSwgc3RydWN0IHNvY2sgKnNrLAo+PiArCQkJCSAgIHN0cnVjdCB2
aXJ0aW9fbmV0X2hkciAqaGRyKQo+PiArewo+PiArCXN0cnVjdCBza19idWZmICpza2I7Cj4+ICsJ
dW5zaWduZWQgbG9uZyBmbGFnczsKPj4gKwlpbnQgdmxhbl9obGVuID0gMDsKPj4gKwlpbnQgcmV0
Owo+PiArCj4+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnNrLT5za19yZWNlaXZlX3F1ZXVlLmxvY2ss
IGZsYWdzKTsKPj4gKwlza2IgPSBza2JfcGVlaygmc2stPnNrX3JlY2VpdmVfcXVldWUpOwo+PiAr
CWlmICghc2tiKSB7Cj4+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNrLT5za19yZWNlaXZl
X3F1ZXVlLmxvY2ssIGZsYWdzKTsKPj4gKwkJbWVtc2V0KGhkciwgMCwgc2l6ZW9mKCpoZHIpKTsK
Pj4gKwkJaGRyLT5nc29fdHlwZSA9IFZJUlRJT19ORVRfSERSX0dTT19OT05FOwo+PiArCQlyZXR1
cm4gMDsKPj4gKwl9Cj4+ICsJaWYgKHNrYl92bGFuX3RhZ19wcmVzZW50KHNrYikpCj4+ICsJCXZs
YW5faGxlbiA9IFZMQU5fSExFTjsKPj4gKwlyZXQgPSB2aXJ0aW9fbmV0X2hkcl9mcm9tX3NrYihz
a2IsIGhkciwgdmhvc3RfaXNfbGl0dGxlX2VuZGlhbih2cSksCj4+ICsJCQkJICAgICAgdHJ1ZSwg
dmxhbl9obGVuKTsKPj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzay0+c2tfcmVjZWl2ZV9x
dWV1ZS5sb2NrLCBmbGFncyk7Cj4+ICsJcmV0dXJuIHJldDsKPj4gK30KPgo+Cj5UaGlzIG1lYW5z
IHRoZSBoZWFkZXIgd2lsbCBiZSB3cm9uZyBpZiBzb21ldGhpbmcgY29uc3VtZXMKPnRoZSBza2Ig
YWZ0ZXIgd2UgZHJvcCB0aGUgbG9jaywgbm8/Cj4KPlRoYXQncyB3aHkgaW4gdGhlIGVuZCB3ZSBw
dXQgdGhlIGhlYWRlciBmaWxsaW5nIGxvZ2ljCj5pbiB0dW4sIGl0IGNhbiBhdm9pZCByYWNlcyB0
aGVyZS4KPgo+Cj4+ICsKPj4gIHN0YXRpYyBpbnQgdmhvc3RfbmV0X3J4X3BlZWtfaGVhZF9sZW4o
c3RydWN0IHZob3N0X25ldCAqbmV0LCBzdHJ1Y3Qgc29jayAqc2ssCj4+ICAJCQkJICAgICAgYm9v
bCAqYnVzeWxvb3BfaW50ciwgdW5zaWduZWQgaW50ICpjb3VudCkKPj4gIHsKPj4gQEAgLTEyMzks
MTAgKzEyNzIsMTggQEAKPj4gIAkJLyogV2UgZG9uJ3QgbmVlZCB0byBiZSBub3RpZmllZCBhZ2Fp
bi4gKi8KPj4gIAkJaW92X2l0ZXJfaW5pdCgmbXNnLm1zZ19pdGVyLCBJVEVSX0RFU1QsIHZxLT5p
b3YsIGluLCB2aG9zdF9sZW4pOwo+PiAgCQlmaXh1cCA9IG1zZy5tc2dfaXRlcjsKPj4gLQkJaWYg
KHVubGlrZWx5KCh2aG9zdF9obGVuKSkpIHsKPj4gLQkJCS8qIFdlIHdpbGwgc3VwcGx5IHRoZSBo
ZWFkZXIgb3Vyc2VsdmVzCj4+IC0JCQkgKiBUT0RPOiBzdXBwb3J0IFRTTy4KPj4gKwkJaWYgKHVu
bGlrZWx5KHZob3N0X2hsZW4pKSB7Cj4+ICsJCQkvKgo+PiArCQkJICogQnVpbGQgdmlydGlvX25l
dF9oZHIgZnJvbSB0aGUgc29ja2V0IHNrYiBiZWZvcmUKPj4gKwkJCSAqIHJlY3Ztc2cgY29uc3Vt
ZXMgaXQuIFNraXAgZm9yIHB0cl9yaW5nIGJhY2tlbmRzCj4+ICsJCQkgKiB3aGVyZSB0aGUgc2ti
IGlzIG5vdCBvbiBza19yZWNlaXZlX3F1ZXVlLgo+PiAgCQkJICovCj4+ICsJCQlpZiAoIW52cS0+
cnhfcmluZyAmJgo+PiArCQkJICAgIHZob3N0X25ldF9oZHJfZnJvbV9zb2NrKHZxLCBzb2NrLT5z
aywgJmhkcikpIHsKPj4gKwkJCQl2cV9lcnIodnEsICJGYWlsZWQgdG8gYnVpbGQgdm5ldF9oZHIg
ZnJvbSBza2JcbiIpOwo+PiArCQkJCXZob3N0X2Rpc2NhcmRfdnFfZGVzYyh2cSwgaGVhZGNvdW50
LCBuZGVzYyk7Cj4+ICsJCQkJY29udGludWU7Cj4+ICsJCQl9Cj4+ICAJCQlpb3ZfaXRlcl9hZHZh
bmNlKCZtc2cubXNnX2l0ZXIsIHZob3N0X2hsZW4pOwo+PiAgCQl9Cj4+ICAJCWVyciA9IHNvY2st
Pm9wcy0+cmVjdm1zZyhzb2NrLCAmbXNnLAo+PiBAQCAtMTI3MCw3ICsxMzExLDYgQEAKPj4gIAkJ
CSAqLwo+PiAgCQkJaW92X2l0ZXJfYWR2YW5jZSgmZml4dXAsIHNpemVvZihoZHIpKTsKPj4gIAkJ
fQo+PiAtCQkvKiBUT0RPOiBTaG91bGQgY2hlY2sgYW5kIGhhbmRsZSBjaGVja3N1bS4gKi8KPj4g
IAo+PiAgCQludW1fYnVmZmVycyA9IGNwdV90b192aG9zdDE2KHZxLCBoZWFkY291bnQpOwo+PiAg
CQlpZiAobGlrZWx5KHNldF9udW1fYnVmZmVycykgJiYK

